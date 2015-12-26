class ScheduleFicoMeanFetch
  include Sidekiq::Worker

  def perform
    # run 100 loans every 30 minutes
    num = 100
    Loan.
      where("fico_mean is null").
      where("loan_id is not null").
      first(num).map{|l| FetchLoanFicoWorker.perform_async(l.loan_id) }
  end
end
