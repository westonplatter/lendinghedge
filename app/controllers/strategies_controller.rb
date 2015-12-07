class StrategiesController < ApplicationController
  before_filter :authenticate_user!

  def index
    @strategies = current_user.strategies
  end

  def show
    @strategy = current_user.strategies.find(params[:id])

    @result = Loan.limit(100)
    @result = @result.ransack(@strategy.search_params.to_hash)
    @result = @result.result(distict: true)
  end

  def new
    @strategy = current_user.strategies.new
  end

  def create
    @strategy = current_user.strategies.new(new_params)

    if @strategy.save
      redirect_to(action: :show, id: @strategy.id)
    else
      redirect_to(action: :index)
    end
  end

  def edit
    @strategy = current_user.strategies.find(params[:id])
  end

  def update
    @strategy = current_user.strategies.find(params[:id])

    if @strategy.update_attributes(update_parmas)
      redirect_to(action: :show, id: @strategy.id)
    else
      redirect_to(action: :edit, id: @strategy.id)
    end
  end

  def delete
    @strategy = current_user.strategies.find(params[:id])

    if @strategy.destroy
      redirect_to(action: :index)
    else
      redirect_to(action: :show, id: @strategy.id)
    end
  end

  private

  def update_parmas
    params.require(:strategy).permit(
      :name,
      :search_params
    )
  end

  def new_params
    params.require(:strategy).permit(
      :name,
      :search_params
    )
  end

end
