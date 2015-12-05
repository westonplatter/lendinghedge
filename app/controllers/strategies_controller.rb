class StrategiesController
  before_filter: authenticate_user!

  def index
    @strategies = current_user.strategies
  end

  def show
    @strategy = current_user.strategies.find(params[:id])
  end

  def create
    @strategy = current_user.strategies.new
  end

  def edit
    @strategy = current_user.strategies.find(params[:id])
  end

  def update
    @strategy = current_user.strategies.find(params[:id])

    if @strategy.update_attibutes(update_parmas)
      redirect_to action: :show
    else
      redirect_to action: :edit
    end
  end

  def delete
    @strategy = current_user.strategies.find(params[:id])

    if @strategy.destroy
      redirect_to action: :index
    else
      redirect_to action: :show
    end
  end

  private

  def update_parmas
  end

  def new_params
  end

end
