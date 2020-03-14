FactoryBot.define do
  factory :work_day do
    date { Time.zone.today }
  end
end
