class Users::RegistrationsController < Devise::RegistrationsController

  before_filter :configure_permitted_parameters

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
      :lending_club_access_token,
    )}
  end
end
