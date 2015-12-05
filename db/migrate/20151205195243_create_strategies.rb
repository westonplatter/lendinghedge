class CreateStrategies < ActiveRecord::Migration
  def change
    create_table :strategies do |t|
      t.integer :user_id
      t.string :name
      t.json :search_params
      t.timestamps null: false
    end
  end
end
