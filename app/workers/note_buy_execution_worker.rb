class NoteBuyExecutionWorker
  include Sidekiq::Worker

  sidekiq_options \
    :queue => :critical,
    :retry => false,
    :backtrace => true

  def perform(strategy_id)
    strategy = Strategy.find(strategy_id)

    # initialize the LC client
    # initialize the Efolio Order Collection
    # api call
    # save the transaction
  end
end
