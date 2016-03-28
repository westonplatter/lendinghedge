class AddSellPriceToUserNotes < ActiveRecord::Migration
  def change
    add_column :user_notes, :sell_price, :decimal, precision: 16, scale: 8
  end
end
