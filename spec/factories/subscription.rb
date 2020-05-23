FactoryBot.define do
  factory :subscription do
    today = Time.zone.today

    ends_on { today + 1.year }
    starts_on { today }
  end
end
