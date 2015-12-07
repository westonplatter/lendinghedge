module ApplicationHelper

  def active_path?(path)
     current_page?(path) ? "active" : ""
  end

end
