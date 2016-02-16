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
    client = LendingClub::API.new(options)

    # initialize the Efolio Order Collection
    notes = strategy.max_matching_notes
    max_orders = notes.collect{|x| x.init_lc_efolio_order }

    investor_id = user.lending_club_investor_id
    return if investor_id.nil?
    order_collection = LendingClub::EfolioOrderCollection.new(orders, investor_id)

    # api call
    result = api.efolio_buy(order_collection)

    puts result.inspect
  end
end
