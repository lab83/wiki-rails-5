FactoryGirl.define do
  factory :user do
    factory :registered_user do
      sequence(:email) { |n| "testuser#{n}@example.com" }
      password '1234567A'
      password_confirmation '1234567A'
      confirmed_at Time.now
    end
  end
end
