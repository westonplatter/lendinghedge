class ScheduleFicoMeanFetch
  include Sidekiq::Worker

  def perform
    # run 150 loans every 30 minutes
    num = 75
    Loan.
      where("fico_mean is null").
      where("loan_id is not null").
      first(num).map{|l| FetchLoanFicoWorker.perform_async(l.loan_id) }
  end
end
