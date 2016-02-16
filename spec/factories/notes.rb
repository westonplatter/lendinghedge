# == Schema Information
#
# Table name: notes
#
#  id                      :integer          not null, primary key
#  loan_id                 :integer
#  note_id                 :integer
#  order_id                :integer
#  outstanding_principal   :decimal(16, 8)
#  accrued_interest        :decimal(16, 8)
#  status                  :string
#  ask_price               :decimal(16, 8)
#  markup_discount         :decimal(16, 8)
#  ytm                     :decimal(16, 8)
#  days_since_last_payment :integer
#  credit_score_trend      :string
#  fico_end_range_mean     :decimal(16, 8)
#  datetime_listed         :datetime
#  never_late              :boolean
#  loan_class              :string
#  loan_maturity           :integer
#  original_note_amount    :decimal(16, 8)
#  interest_rate           :decimal(16, 8)
#  remaining_payments      :integer
#  principal_interest      :decimal(16, 8)
#  application_type        :string
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#  market_status           :integer          default(0)
#

FactoryGirl.define do

  factory :note do
    loan_id 1
    order_id 2
    note_id 3
    ask_price 10.02
  end

end
