class CreateLoans < ActiveRecord::Migration
  def change
    create_table :loans do |t|
      t.integer :loan_id
      t.integer :member_id
      t.decimal :loan_amnt, precision: 16, scale: 8
      t.decimal :funded_amnt, precision: 16, scale: 8
      t.decimal :funded_amnt_inv, precision: 16, scale: 8
      t.integer :term
      t.decimal :int_rate, precision: 16, scale: 8
      t.decimal :installment, precision: 16, scale: 8
      t.string :grade
      t.string :sub_grade
      t.string :emp_title
      t.string :emp_length
      t.string :home_ownership
      t.decimal :annual_inc, precision: 16, scale: 8
      t.decimal :verification_status
      t.datetime :issue_d
      t.string :loan_status
      t.string :pymnt_plan
      t.string :url
      t.text :desc
      t.text :purpose
      t.string :title
      t.string :zip_code
      t.string :addr_state
      t.decimal :dti, precision: 16, scale: 8
      t.integer :delinq_2yrs
      t.datetime :earliest_cr_line
      t.integer :inq_last_6mths
      t.integer :mths_since_last_delinq
      t.integer :mths_since_last_record
      t.integer :open_acc
      t.integer :pub_rec
      t.decimal :revol_bal, precision: 16, scale: 8
      t.decimal :revol_util, precision: 16, scale: 8
      t.decimal :total_acc, precision: 16, scale: 8
      t.string :initial_list_status
      t.decimal :out_prncp, precision: 16, scale: 8
      t.decimal :out_prncp_inv, precision: 16, scale: 8
      t.decimal :total_pymnt, precision: 16, scale: 8
      t.decimal :total_pymnt_inv, precision: 16, scale: 8
      t.decimal :total_rec_prncp, precision: 16, scale: 8
      t.decimal :total_rec_int, precision: 16, scale: 8
      t.decimal :total_rec_late_fee, precision: 16, scale: 8
      t.decimal :recoveries, precision: 16, scale: 8
      t.decimal :collection_recovery_fee, precision: 16, scale: 8
      t.datetime :last_pymnt_d
      t.decimal :last_pymnt_amnt, precision: 16, scale: 8
      t.datetime :next_pymnt_d
      t.datetime :last_credit_pull_d
      t.integer :collections_12_mths_ex_med
      t.integer :mths_since_last_major_derog
      t.string :policy_code
      t.string :application_type
      t.decimal :annual_inc_joint, precision: 16, scale: 8
      t.decimal :dti_joint, precision: 16, scale: 8
      t.string :verification_status_joint

      t.timestamps null: false
    end
  end
end
