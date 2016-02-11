class AddActiveToStrategies < ActiveRecord::Migration
  def change
    add_column :strategies, :active, :boolean
  end
end
