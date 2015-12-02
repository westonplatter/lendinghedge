class FetchLoanFicoWorker
  include Sidekiq::Worker

  def perform(loan_id)
    sleep 10

    logger.info "FetchLoanFico for LoanId = #{loan_id}"

    Loan.fetch_fico_by_loan_id(loan_id)
  end
end
