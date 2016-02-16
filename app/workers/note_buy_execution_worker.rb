class NoteBuyExecutionWorker
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
    orders = notes.collect{|x| x.init_lc_efolio_order }

    investor_id = user.lending_club_investor_id
    return if investor_id.nil?
    # order_collection = LendingClub::EfolioOrderCollection.new(orders, investor_id)

    # make lending club api call
    result = client.efolio_buy(orders)

    result.each do |order|
      note = Note.where(note_id: order.note_id).first
      unless note.nil?
        note.update_attriubutes(market_status: Note.market_statuses[:archived])
      end
    end
  end
end
