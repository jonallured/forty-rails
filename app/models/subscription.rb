class Subscription < ApplicationRecord
  belongs_to :user

  scope :active, lambda {
    today = Time.zone.today
    where('starts_on >= ? AND ends_on >= ?', today, today)
  }

  scope :comped, -> { where(comped: true) }

  def status
    today = Time.zone.today
    active = starts_on >= today && ends_on >= today
    active ? 'active' : 'expired'
  end
end
