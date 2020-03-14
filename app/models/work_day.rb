class WorkDay < ApplicationRecord
  belongs_to :user
  validates :date, presence: true, uniqueness: { scope: :user_id }
  delegate :year, to: :date
end
