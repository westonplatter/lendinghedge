require 'csv'

module Admin
  class NotesController < BaseController

    def index
      @notes = Note.first(100)
    end

    def show
      @note = Note.find(params[:id])
    end

    def upload
    end

    def post_upload
      CSV.parse(params[:file].read, :headers => true) do |row|
        attrs = Note.parse_csv_row(row).attributes

        begin
          NoteCreatorWorker.perform_async(attrs)
        rescue Exception => e
          puts "----------------"
          puts e.message
          puts attrs.inspect
        end
      end

      redirect_to action: :upload
    end

    def download_and_load
      DownloadEfolioWorker.perform_async
    end

  end
end
