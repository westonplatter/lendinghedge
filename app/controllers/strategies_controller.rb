class StrategiesController < ApplicationController
  before_filter :authenticate_user!

  def index
    @strategies = current_user.strategies
  end

  def show
    @strategy = current_user.strategies.find(params[:id])

    @loans = nil
    @notes = nil

    if !@strategy.search_params.blank?
      @loans = Loan.
        ransack(@strategy.search_params.to_hash).
        result(distict: true)

      note_ransack_params = Note.ransack_params_from_strategy(@strategy.search_params)

      @notes = Note.
        ransack(note_ransack_params).
        result(distict: true)
    else
      nil
    end
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

  def destroy
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
      :search_params,
      :active,
      :execution_params,
    )
  end

  def new_params
    params.require(:strategy).permit(
      :name,
      :search_params,
      :active,
      :execution_params,
    )
  end

end
