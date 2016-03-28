class AddInterestRateToUserNotes < ActiveRecord::Migration
  def change
    add_column :user_notes, :interest_rate, :decimal, precision: 16, scale: 8
  end
end
