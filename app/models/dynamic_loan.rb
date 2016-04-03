# == Schema Information
#
# Table name: dynamic_loans
#
#  id                          :integer
#  loan_id                     :integer
#  member_id                   :integer
#  loan_amnt                   :decimal(16, 8)
#  funded_amnt                 :decimal(16, 8)
#  funded_amnt_inv             :decimal(16, 8)
#  term                        :integer
#  int_rate                    :decimal(16, 8)
#  installment                 :decimal(16, 8)
#  grade                       :string
#  sub_grade                   :string
#  emp_title                   :string
#  emp_length                  :string
#  home_ownership              :string
#  annual_inc                  :decimal(16, 8)
#  verification_status         :decimal(, )
#  issue_d                     :datetime
#  loan_status                 :string
#  pymnt_plan                  :string
#  url                         :string
#  desc                        :text
#  purpose                     :text
#  title                       :string
#  zip_code                    :string
#  addr_state                  :string
#  dti                         :decimal(16, 8)
#  delinq_2yrs                 :integer
#  earliest_cr_line            :datetime
#  inq_last_6mths              :integer
#  mths_since_last_delinq      :integer
#  mths_since_last_record      :integer
#  open_acc                    :integer
#  pub_rec                     :integer
#  revol_bal                   :decimal(16, 8)
#  revol_util                  :decimal(16, 8)
#  total_acc                   :decimal(16, 8)
#  initial_list_status         :string
#  out_prncp                   :decimal(16, 8)
#  out_prncp_inv               :decimal(16, 8)
#  total_pymnt                 :decimal(16, 8)
#  total_pymnt_inv             :decimal(16, 8)
#  total_rec_prncp             :decimal(16, 8)
#  total_rec_int               :decimal(16, 8)
#  total_rec_late_fee          :decimal(16, 8)
#  recoveries                  :decimal(16, 8)
#  collection_recovery_fee     :decimal(16, 8)
#  last_pymnt_d                :datetime
#  last_pymnt_amnt             :decimal(16, 8)
#  next_pymnt_d                :datetime
#  last_credit_pull_d          :datetime
#  collections_12_mths_ex_med  :integer
#  mths_since_last_major_derog :integer
#  policy_code                 :string
#  application_type            :string
#  annual_inc_joint            :decimal(16, 8)
#  dti_joint                   :decimal(16, 8)
#  verification_status_joint   :string
#  created_at                  :datetime
#  updated_at                  :datetime
#  fico_mean                   :integer
#

class DynamicLoan < ActiveRecord::Base
end
