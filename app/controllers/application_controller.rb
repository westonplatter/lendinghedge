class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception


  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(
      :email,
      :password,
      :password_confirmation,
      :remember_me
    )}

    devise_parameter_sanitizer.for(:sign_in) { |u| u.permit(
      :email,
      :password,
      :remember_me
    )}

    devise_parameter_sanitizer.for(:account_update) { |u| u.permit(
      :email,
      :password,
      :password_confirmation,
      :current_password,
      :lending_club_investor_id,
      :lending_club_api_key
    )}
  end
end
