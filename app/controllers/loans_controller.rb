class LoansController < ApplicationController
  def index
    @q = Loan.limit(10)
    @q = @q.ransack(params[:q])
    @loans = @q.result(distict: true)
  end

  def search
    @q = Loan.limit(100)
    @q = @q.ransack(params[:q])
    @loans = @q.result(distict: true)
    @new_strategy_params = { strategy: {search_params: params[:q].to_json }}
  end

  def show
    @loan = Loan.find(params[:id])
  end
end
