class CreateUserNotes < ActiveRecord::Migration
  def change
    create_table :user_notes do |t|
      t.string :loan_status
      t.integer :loan_id
      t.string :portfolio_name
      t.integer :portfolio_id
      t.integer :note_id
      t.string :grade
      t.decimal :loan_amount, precision: 16, scale: 8
      t.decimal :accrued_interest, precision: 16, scale: 8
      t.decimal :note_amount, precision: 16, scale: 8
      t.string :purpose
      t.integer :order_id
      t.integer :loan_length
      t.datetime :issue_date
      t.datetime :order_date
      t.datetime :loan_status_date
      t.string :credit_trend
      t.string :current_payment_status
      t.boolean :can_be_traded
      t.decimal :payments_received, precision: 16, scale: 8
      t.datetime :next_payment_date
      t.decimal :principal_pending, precision: 16, scale: 8
      t.decimal :interest_pending, precision: 16, scale: 8
      t.decimal :interest_received, precision: 16, scale: 8
      t.decimal :principal_received, precision: 16, scale: 8

      t.timestamps null: false
    end
  end
end
