class FetchLoanFicoWorker
  include Sidekiq::Worker

  sidekiq_options \
    :queue => :low,
    :retry => false,
    :backtrace => true,
    :rate  => {
                :name   => 'lending_club_ui_throttler',
                :limit  => 1,
                :period => 10, ## seconds
              }

  def perform(loan_id)
    random_sleep_delay

    begin
      logger.info "FetchLoanFico for LoanId = #{loan_id}"
      Loan.fetch_fico_by_loan_id(loan_id)
    rescue Exception => e
      @retries ||= 0
      if @retries < 2
        logger.info "Refreshing cookies"
        SaveCookieJarWorker.new.perform()
        @retries += 1
        retry
      else
        logger.error "ERROR - Could not fetch FICO for Loan ID=#{loan_id}"
      end
    end
  end

  def random_sleep_delay
    duration = 5
    duration += Random.new.rand(1...5)

    if Random.new.rand(1...10) >= 5
      duration += Random.new.rand(1...5)
    end

    sleep(duration)
  end
end
