class DashboardController < ApplicationController
  before_action :authenticate_user!

  def index
    @accounts = []

    unless current_user.lending_club_investor_id.nil?
      options = {
        access_token: current_user.lending_club_access_token,
        investor_id: current_user.lending_club_investor_id,
      }
      client = LendingClub::Client.new(options)

      @accounts << client.summary
    end
  end
end
