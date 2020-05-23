FactoryBot.define do
  factory :subscription do
    today = Time.zone.today

    comped { false }
    ends_on { today + 1.year }
    starts_on { today }
  end

  factory :comped_subscription, class: :subscription do
    today = Time.zone.today

    comped { true }
    ends_on { today + 1.year }
    starts_on { today }
  end
end
