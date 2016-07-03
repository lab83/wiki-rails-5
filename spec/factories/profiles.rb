FactoryGirl.define do
  factory :profile do
    factory :valid_profile do
      sequence(:email) { |n| "testuser#{n}@example.com" }
    end
  end
end
