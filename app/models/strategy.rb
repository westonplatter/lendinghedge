# == Schema Information
#
# Table name: strategies
#
#  id            :integer          not null, primary key
#  user_id       :integer
#  name          :string
#  search_params :json
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  deleted_at    :datetime
#

class Strategy < ActiveRecord::Base
  belongs_to :user

  resourcify
  acts_as_paranoid

  def short_name
    self.name.try(:truncate, 25)
  end
end
