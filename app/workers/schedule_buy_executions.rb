class ScheduleBuyExecutions
  include Sidekiq::Worker

  sidekiq_options \
    :queue => :critical,
    :retry => false,
    :backtrace => true

  def perform
    Strategy.where(active: true).each {|x| StrategyBuyExecutionWorker.perform_async(x.id) }
  end
end
