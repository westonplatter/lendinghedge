class UserNotesController < ApplicationController
  before_filter :authenticate_user!

  def index
    @user_notes = current_user.user_notes
  end

  def import
    UserNote.import_user_notes(current_user.id)
    redirect_to(action: :index)
  end

  def sell
  end
end
