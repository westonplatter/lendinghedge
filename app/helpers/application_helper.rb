module ApplicationHelper
  def active_path?(path)
    current_page?(path) ? "active" : ""
  end

  def display_strategies
    if current_user
      current_user.strategies.order(:updated_at).limit(10)
    else
      []
    end
  end

end
