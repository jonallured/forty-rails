class Subscription < ApplicationRecord
  belongs_to :user

  scope :active, lambda {
    today = Time.zone.today
    where('starts_on >= ? AND ends_on >= ?', today, today)
  }
end
