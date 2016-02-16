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

FactoryGirl.define do
  sequence (:email) {|n| "user-#{n}@lendinghedge.com"}

  factory :user do
    email { generate(:email)}
    password "password"
    password_confirmation "password"

    factory :user_lending_club do
      lending_club_inestor_id 123
      lending_club_access_token "abc"
    end
  end

end
