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
