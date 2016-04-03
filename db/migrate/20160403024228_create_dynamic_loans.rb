class CreateDynamicLoans < ActiveRecord::Migration
  def change
    create_view :dynamic_loans
  end
end
