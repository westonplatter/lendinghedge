class FetchLoanFicoWorker
  include Sidekiq::Worker

  def perform(loan_id)
    base = 5
    r = Random.new
    random = r.rand(1...4)

    rr = Random.new
    random_adhd = rr.rand(1...10)

    total = base + random
    if random_adhd > 4
      rrr = Random.new
      random_add = rr.rand(1...3)
      total += (random_add*2.0)
    end

    sleep(total)

    logger.info "FetchLoanFico for LoanId = #{loan_id}"

    Loan.fetch_fico_by_loan_id(loan_id)
  end
end
