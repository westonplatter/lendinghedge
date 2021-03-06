module Admin
  class BaseController < ApplicationController
    layout 'admin'

    before_filter :authenticate_admin!

    def authenticate_admin!
      unless current_user.admin?
        redirect_to root_path
      end
    end

  end
end


