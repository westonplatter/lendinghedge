# == Schema Information
#
# Table name: user_notes
#
#  id                     :integer          not null, primary key
#  loan_status            :string
#  loan_id                :integer
#  portfolio_name         :string
#  portfolio_id           :integer
#  note_id                :integer
#  grade                  :string
#  loan_amount            :decimal(16, 8)
#  accrued_interest       :decimal(16, 8)
#  note_amount            :decimal(16, 8)
#  purpose                :string
#  order_id               :integer
#  loan_length            :integer
#  issue_date             :datetime
#  order_date             :datetime
#  loan_status_date       :datetime
#  credit_trend           :string
#  current_payment_status :string
#  can_be_traded          :boolean
#  payments_received      :decimal(16, 8)
#  next_payment_date      :datetime
#  principal_pending      :decimal(16, 8)
#  interest_pending       :decimal(16, 8)
#  interest_received      :decimal(16, 8)
#  principal_received     :decimal(16, 8)
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  user_id                :integer
#  interest_rate          :decimal(16, 8)
#  sell_price             :decimal(16, 8)
#

class UserNote < ActiveRecord::Base
  belongs_to :user

  def self.import_user_notes(user_id)
    UserNote.where(user_id: user_id).delete_all

    user = User.find(user_id)

    options = {
      access_token: user.lending_club_access_token,
      investor_id: user.lending_club_investor_id,
    }
    client = LendingClub::Client.new(options)
    notes = client.notes

    notes.each do |note|
      UserNote.find_or_create(user_id, note)
    end
  end


  def self.find_or_create(user_id, note)
    x = UserNote.where(user_id: user_id).
          where(note_id: note.note_id).
          where(loan_id: note.loan_id).
          where(order_id: note.order_id).
          first

    if x

    else
      x = UserNote.new(note.to_h)
      x.user_id = user_id
    end

    x.save
    return x
  end
end
