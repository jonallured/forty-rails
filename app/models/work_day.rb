class WorkDay < ApplicationRecord
  belongs_to :user
  validates :date, presence: true, uniqueness: { scope: :user_id }
  delegate :year, to: :date

  def as_json(*_)
    {
      adjustMinutes: adjust_minutes,
      dayOfWeek: date.strftime('%A'),
      id: id,
      inMinutes: in_minutes,
      outMinutes: out_minutes,
      ptoMinutes: pto_minutes
    }
  end
end
