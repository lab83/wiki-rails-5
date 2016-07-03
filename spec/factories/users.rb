FactoryGirl.define do
  factory :user do
    factory :valid_user do
      sequence(:email) { |n| "testuser#{n}@example.com" }
      password '1234567A'
      password_confirmation '1234567A'

      factory :confirmed_user do
        confirmed_at Time.now
        unconfirmed_email nil
      end
    end
  end
end
