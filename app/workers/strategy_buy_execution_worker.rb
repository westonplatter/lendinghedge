class StrategyBuyExecutionWorker
  include Sidekiq::Worker

  sidekiq_options \
    :queue => :critical,
    :retry => false,
    :backtrace => true

  def perform(strategy_id)
    strategy = Strategy.find(strategy_id)

    # initialize the LC client
    user = strategy.user
    options = {
      access_token: user.lending_club_access_token,
      investor_id: user.lending_club_investor_id,
    }
    client = LendingClub::Client.new(options)

    # initialize the Efolio Order Collection
    notes = strategy.max_matching_notes
    return if notes.empty?
    orders = notes.collect{|x| x.init_lc_efolio_order }

    investor_id = user.lending_club_investor_id
    return if investor_id.nil?

    # make lending club api call
    result = client.efolio_buy(orders)

    result.each do |order|
      note = Note.find_by(note_id: order.note_id)
      note.archived!
    end
  end

end
