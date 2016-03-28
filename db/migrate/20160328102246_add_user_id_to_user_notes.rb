class AddUserIdToUserNotes < ActiveRecord::Migration
  def change
    add_column :user_notes, :user_id, :integer
  end
end
