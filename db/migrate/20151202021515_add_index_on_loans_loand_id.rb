class AddIndexOnLoansLoandId < ActiveRecord::Migration
  def change
    add_index :loans, :loan_id
  end
end
