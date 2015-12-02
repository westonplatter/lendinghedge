class LoanCreatorWorker
 include Sidekiq::Worker

  def perform(attrs)
    if Loan.where(loan_id: attrs["loan_id"]).first
      # nothing
    else
      Loan.create(attrs)
    end
  end
end
