FactoryBot.define do
  factory :user do
    confirmed_at { Time.zone.now }
    sequence(:email) { |n| "user#{n}@example.com" }
    password { 'sh' * 9 }
  end
end
