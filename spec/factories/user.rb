FactoryBot.define do
  factory :user, aliases: [:free_user] do
    confirmed_at { Time.zone.now }
    sequence(:email) { |n| "user#{n}@example.com" }
    password { 'sh' * 9 }

    factory :active_user do
      after(:create) do |user|
        FactoryBot.create(:subscription, user: user)
      end
    end

    factory :comped_user do
      after(:create) do |user|
        FactoryBot.create(:comped_subscription, user: user)
      end
    end
  end
end
