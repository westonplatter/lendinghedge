class ImportEfolioWorker
  include Sidekiq::Worker

  sidekiq_options \
    :queue => :critical,
    :retry => false,
    :backtrace => true

  def perform(file_full_path)
    Importer::Efolio.import(file_full_path)
  end
end
