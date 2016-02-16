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

require 'rails_helper'

RSpec.describe Note, type: :model do
  it { should belong_to :loan }

  describe ".ransack_params_from_strategy" do

    it "should return only dti_gteq" do
      params_hash = {"dti_gteq" => 20}
      r = Note.ransack_params_from_strategy(params_hash)
      expect(r["loan_dti_gteq"]).to eq(20)
      expect(r.keys.size).to eq(1)
    end

  end

  describe "#init_lc_order" do
    it "should return a legit LendingClub::EfolioOrder" do
      note = FactoryGirl.create(:note)

      efolio_order = note.init_lc_efolio_order

      expect(efolio_order.note_id).to eq(note.note_id)
      expect(efolio_order.order_id).to eq(note.order_id)
      expect(efolio_order.loan_id).to eq(note.loan_id)
      expect(efolio_order.bid_price).to eq(note.ask_price)
    end
  end

end
