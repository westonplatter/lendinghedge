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

require 'rails_helper'

RSpec.describe Strategy, type: :model do
end
