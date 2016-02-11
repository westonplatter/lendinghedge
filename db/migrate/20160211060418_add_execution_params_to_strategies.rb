class AddExecutionParamsToStrategies < ActiveRecord::Migration
  def change
    add_column :strategies, :execution_params, :json
  end
end
