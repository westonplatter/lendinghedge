require 'csv'

module Importer::Efolio

  FIELDS = %w{
    loan_id
    note_id
    order_id
    outstanding_principal
    accrued_interest
    status
    ask_price
    markup_discount
    ytm
    days_since_last_payment
    credit_score_trend
    fico_end_range_mean
    datetime_listed
    never_late
    loan_class
    loan_maturity
    original_note_amount
    interest_rate
    remaining_payments
    principal_interest
    application_type
    created_at
    updated_at
    market_status
  }

  #
  # download
  #
  def self.download
    agent = Mechanize.new { |a|
      a.user_agent_alias = 'Mac Safari'
    }

    agent.get('https://www.lendingclub.com/account/gotoLogin.action') do |page|
      page.form_with(:action => '/account/login.action') do |form|
        form.login_email =  ENV['LENDINGCLUB_EMAIL']
        form.login_password = ENV['LENDINGCLUB_PASSWORD']
      end.submit
    end

    timestamp = Time.now.to_formatted_s(:iso8601)
    filename = "notes-#{timestamp}.csv"
    full_file_path = Rails.root.join("tmp/downloads/", filename)

    agent.pluggable_parser.default = Mechanize::Download
    agent.get('https://resources.lendingclub.com/SecondaryMarketAllNotes.csv').save(full_file_path)

    sleep 2

    ImportEfolioWorker.perform_async(full_file_path)
  end

  #
  # import
  #
  def self.import(file)
    remove_intactive_notes(file)

    i = 0

    full_file_path = file
    total_lines = (`wc -l < #{full_file_path}`).to_i

    # IO.foreach doesn't read the entire file into memory at once, which is good since a standard FasterCSV.parse on this file can take an hour or more
    lines = []

    IO.foreach(full_file_path) do |line|
      i += 1
      next if i < 2

      lines << line

      if lines.size >= 1000
        exception_logger.info("line #{i}    ---    progresss % = #{(1.0*i)/total_lines}")

        begin
          store lines
        rescue Exception => e
          exception_logger.error('-----------------------------------')
          exception_logger.error(e)
          exception_logger.error('---')
          exception_logger.error("line = #{i}")
        ensure
        end

        lines = []
      end
    end

    store(lines) unless lines.empty?

    cleanup(file)

    execute_active_strategies
  end

  #
  # reset market status
  #
  def self.remove_intactive_notes(full_file_path)

    Note.delete_all
    return

    i = 0

    # co, current orders
    Note.
      active.
      select(:id, :order_id).
      find_each(batch_size: 5000) do |n|
        i += 1
        exception_logger.info("current_order #{i}") if (i%1000 == 0)
        $redis.sadd :note_current_order_ids, n.order_id
      end

    i = 0

    # io, import orders
    IO.foreach(full_file_path) do |line|
      i += 1
      next if i < 2

      x = CSV.parse(line, options = {col_sep: ',', row_sep: "\n", skip_blanks: true})
      parsed_line = x.first
      next if parsed_line.nil?

      exception_logger.info("import_orders line ##{i}") if (i%1000 == 0)

      $redis.sadd :note_import_order_ids, parsed_line[2]
    end

    exception_logger.info("sdiffstore start")

    $redis.sdiffstore(
      :note_diff_order_ids,
      :note_current_order_ids,
      :note_import_order_ids
    )

    exception_logger.info("sdiffstore end")

    order_ids = []
    status = Note.market_statuses[:archived]

    exception_logger.info("update_market_status start")

    i = 0

    $redis.smembers(:note_diff_order_ids).each do |order_id|
      order_ids << order_id

      if order_ids.size > 5000
        i += 1
        msg = "update_market_status ##{i}"
        exception_logger.info(msg) if (i%1000 == 0)

        update_market_status(order_ids, status)
        order_ids = []
      end
    end

    update_market_status(order_ids, status)

    exception_logger.info("update_market_status end")

    $redis.del :note_diff_order_ids
    $redis.del :note_current_order_ids
    $redis.del :note_import_order_ids

    exception_logger.info("remove_intactive_notes end")
  end

  def self.update_market_status(order_ids, status)
    formatted_note_ids = order_ids.collect(&:to_i).join(",")

    sql = <<-end.squish
      UPDATE #{table_name}
      SET market_status = #{status}
      WHERE order_id IN (#{formatted_note_ids})
    end

    connection.execute(sql)
  end

  #
  # cleanup
  #
  def self.cleanup(file)
    File.delete(file)
  end

  #
  # buy notes
  #
  def self.execute_active_strategies
    Strategy.where(active: true).each {|x| StrategyBuyExecutionWorker.perform_async(x.id) }
  end

  def self.exception_logger
    @@exception_logger ||= Logger.new("#{Rails.root}/log/import_logger.log")
  end

  def self.table_name
    "notes"
  end

  def self.store(lines)
    lines = CSV.parse(lines.join, options = {col_sep: ',', row_sep: "\n", skip_blanks: true})
    return if lines.empty?

    sql = <<-end.squish
      INSERT INTO #{table_name} (#{fields_to_sql(FIELDS)})
      VALUES #{data_to_sql(lines)}
      ON CONFLICT (note_id)
      DO UPDATE SET #{fields_to_update_sql(FIELDS[1..-1])}
    end

    begin
      connection.execute(sql)
    rescue Exception => e
      exception_logger.debug("---------------------------------------------------")
      exception_logger.debug(e)
    end
  end

  def self.fields_to_sql(fields)
    fields.join(', ')
  end

  def self.data_to_sql(lines)
    now = Time.now.utc.to_s
    created_at, updated_at = [now, now]
    market_status = Note.market_statuses[:active]

    lines = lines.collect{|l| l << created_at; l << updated_at; l << market_status }

    data = lines.collect{ |x| transform_row(x) }.compact

    data.collect do |row|
      "(#{row.collect{|f| connection.quote(f)}.join(',')})"
    end.join(', ')
  end

  def self.transform_row(x)
    # calc fico_mean score
    if x[11].include?("-")
      x[11] = (x[11].split("-").collect(&:to_i).inject(:+) * 1.0)/2
    end

    # ytm
    x[8] = nil if x[8] == "--"

    # days_since_last_payment
    x[9] = "" if x[9].nil?

    return x
  end

  def self.connection
    config   = Rails.configuration.database_configuration[Rails.env]

    @connection ||= ActiveRecord::Base.establish_connection(
      :adapter  => config["adapter"],
      :host     => config["host"],
      :username => config["username"],
      :password => config["password"],
      :database => config["database"]
    ).checkout
  end

  def self.fields_to_update_sql(fields)
    modified_fields = fields.delete("note_id")
    modified_fields = fields.delete("created_at")

    # EXCLUDED means take the upsert values, IE, don't keep old ones
    fields.collect do |f|
      "#{f} = EXCLUDED.#{f}"
    end.join(', ')
  end


end
