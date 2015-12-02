require 'csv'

module Admin
  class LoansController < BaseController

    def index
      @loans = Loan.first(100)
    end

    def show
      @loan = Loan.find(params[:id])
    end

    def upload
    end

    def post_upload
      CSV.parse(params[:file].read, :headers => true) do |row|
        attrs = Loan.parse_csv_row(row).attributes
        begin
          LoanCreatorWorker.perform_async(attrs)
        rescue Exception => e
          puts "----------------"
          puts e.message
          puts attrs.inspect
        end
      end

      redirect_to action: :upload
    end

  end
end
