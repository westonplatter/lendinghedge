class AddFicoMeanToLoans < ActiveRecord::Migration
  def change
    add_column :loans, :fico_mean, :integer
  end
end
