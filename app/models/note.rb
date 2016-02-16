# == Schema Information
#
# Table name: notes
#
#  id                      :integer          not null, primary key
#  loan_id                 :integer
#  note_id                 :integer
#  order_id                :integer
#  outstanding_principal   :decimal(16, 8)
#  accrued_interest        :decimal(16, 8)
#  status                  :string
#  ask_price               :decimal(16, 8)
#  markup_discount         :decimal(16, 8)
#  ytm                     :decimal(16, 8)
#  days_since_last_payment :integer
#  credit_score_trend      :string
#  fico_end_range_mean     :decimal(16, 8)
#  datetime_listed         :datetime
#  never_late              :boolean
#  loan_class              :string
#  loan_maturity           :integer
#  original_note_amount    :decimal(16, 8)
#  interest_rate           :decimal(16, 8)
#  remaining_payments      :integer
#  principal_interest      :decimal(16, 8)
#  application_type        :string
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#  market_status           :integer          default(0)
#

class Note < ActiveRecord::Base
  # include DataConversions

  enum market_status: { active: 0, archived: 1 }

  belongs_to :loan, primary_key: "loan_id"

  class << self
    def parse_csv_row(row)
      x = Note.new(
        loan_id: row["LoanId"],
        note_id: row["NoteId"],
        order_id: row["OrderId"],
        outstanding_principal: row["OutstandingPrincipal"],
        accrued_interest: row["AccruedInterest"],
        status: row["Status"],
        ask_price: row["AskPrice"],
        markup_discount: row["Markup/Discount"],
        ytm: row["YTM"],
        days_since_last_payment: row["DaysSinceLastPayment"],
        credit_score_trend: row["CreditScoreTrend"],
        fico_end_range_mean: compute_fico_mean(row["FICO End Range"]),
        datetime_listed: parse_day_month_year(row["Date/Time Listed"]),
        never_late: to_bool(row["NeverLate"]),
        loan_class: row["Loan Class"],
        loan_maturity: row["Loan Maturity"],
        original_note_amount: row["Original Note Amount"],
        interest_rate: row['Interest Rate'],
        remaining_payments: row["Remaining Payments"],
        principal_interest: row["Principal + Interest"],
        application_type: row["Application Type"]
      )

      return x
    end

    def parse_day_month_year(str)
      return nil if str.nil?
      return nil if str.empty?
      DateTime.strptime(str, '%m/%d/%Y')
    end

    def ransack_params_from_strategy(params_hash)

      mappings = {
        # loan attributes
        "loan_dti_gteq" => "dti_gteq",
        "loan_dti_lteq" => "dti_lteq",

        # note attributes
        "outstanding_principal_lteq" => "outstanding_principal_lteq"
      }

      hash = {}

      mappings.each do |k,v|
        hash[k] = params_hash[v] if !params_hash[v].nil?
      end

      return hash
    end

    def tf
      "/Users/weston/lh/lh_fast/spec/support/efolio_sample.csv"
    end

    def to_bool(x)
      return true   if x == true   || x =~ (/(true|t|yes|y|1)$/i)
      return false  if x == false  || x.blank? || x =~ (/(false|f|no|n|0)$/i)
      raise ArgumentError.new("invalid value for Boolean: \"#{x}\"")
    end

    def compute_fico_mean(fico_range)
      l, h = fico_range.split("-").map(&:to_i)
      return l if (h.nil? and l > 0)
      return h if (l.nil? and h > 0)
      return ((h + l)/2)
    end
  end

  #
  # LendingClub gem
  #
  def init_lc_efolio_order
    LendingClub::EfolioOrder.new(
      self.loan_id,
      self.order_id,
      self.note_id,
      self.ask_price
    )
  end
end
