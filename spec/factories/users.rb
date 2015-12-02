FactoryGirl.define do
  sequence (:email) {|n| "user-#{n}@lendinghedge.com"}

  factory :user do
    email { generate(:email)}
    password "password"
    password_confirmation "password"
  end
end
