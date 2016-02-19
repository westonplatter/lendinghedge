# == Schema Information
#
# Table name: strategies
#
#  id               :integer          not null, primary key
#  user_id          :integer
#  name             :string
#  search_params    :json
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  deleted_at       :datetime
#  execution_params :json
#  active           :boolean
#

class Strategy < ActiveRecord::Base
  resourcify
  acts_as_paranoid

  belongs_to :user

  def short_name
    self.name.try(:truncate, 25)
  end

  def matching_notes
    return nil if search_params.blank?

    note_ransack_params = Note.ransack_params_from_strategy(search_params)
    Note.
      where(market_status: Note.market_statuses[:active]).
      ransack(note_ransack_params).
      result(distict: true)
  end

  def matching_loans
    return nil if search_params.blank?

    Loan.
      ransack(search_params.to_hash).
      result(distict: true)
  end

  def max_matching_notes
    max_invest = execution_params["max_invest"]
    sum = 0

    matching_notes.
      order(:markup_discount).
      limit(10).
      select{|x| sum += x.ask_price; sum <= max_invest }
  end
end
