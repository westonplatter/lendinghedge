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
