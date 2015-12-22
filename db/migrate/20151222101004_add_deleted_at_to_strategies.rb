class AddDeletedAtToStrategies < ActiveRecord::Migration
  def change
    add_column :strategies, :deleted_at, :datetime
    add_index :strategies, :deleted_at
  end
end
