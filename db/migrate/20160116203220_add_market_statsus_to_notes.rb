class AddMarketStatsusToNotes < ActiveRecord::Migration
  def change
    add_column :notes, :market_status, :integer, default: 0
    add_index :notes, [:id, :market_status]
    add_index :notes, [:note_id, :loan_id, :order_id]
  end
end
