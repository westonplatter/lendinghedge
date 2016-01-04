class DownloadEfolioWorker
  include Sidekiq::Worker

  sidekiq_options \
    :queue => :critical,
    :retry => false,
    :backtrace => true

  def perform
    Importer::Efolio.download
  end
end
