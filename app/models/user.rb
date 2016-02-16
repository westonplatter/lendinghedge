# == Schema Information
#
# Table name: users
#
#  id                                  :integer          not null, primary key
#  created_at                          :datetime         not null
#  updated_at                          :datetime         not null
#  email                               :string           default(""), not null
#  encrypted_password                  :string           default(""), not null
#  reset_password_token                :string
#  reset_password_sent_at              :datetime
#  remember_created_at                 :datetime
#  sign_in_count                       :integer          default(0), not null
#  current_sign_in_at                  :datetime
#  last_sign_in_at                     :datetime
#  current_sign_in_ip                  :inet
#  last_sign_in_ip                     :inet
#  encrypted_lending_club_investor_id  :string
#  encrypted_lending_club_access_token :string
#

class User < ActiveRecord::Base
  rolify

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  attr_encrypted :lending_club_investor_id,
    key: ENV['attr_encrypted_key']

  attr_encrypted :lending_club_access_token,
    key: ENV['attr_encrypted_key']

  has_many :strategies
end
