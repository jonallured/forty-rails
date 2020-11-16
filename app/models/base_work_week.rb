class BaseWorkWeek
  class InvalidDates < StandardError; end

  attr_accessor :work_days
  attr_reader :number, :user, :year

  def self.find_or_create_by(user:, year:, number:)
    work_week = WorkWeek.new(user, year, number)
    work_week.find_or_create
    work_week
  rescue InvalidDates
    # year and/or number failed to parse as valid date
  end

  def initialize(user, year, number)
    @user = user
    @year = year.to_i
    @number = number.to_i
    @work_days = []
  end

  def find_or_create
    raise 'Implement in subclass'
  end

  def as_json(_)
    {
      dateSpan: date_span,
      weekToDateIds: week_to_date_ids,
      workDays: work_days
    }
  end

  def target_date
    dates.first
  end

  private

  def week_to_date_ids
    raise 'Implement in subclass'
  end

  def date_span
    monday = dates.first
    friday = dates.last
    (monday..friday).to_s(:date_span)
  end

  def dates
    @dates ||= compute_dates
  end

  def compute_dates
    raise InvalidDates unless year.positive? && number.positive?

    (1..5).map { |day| Date.commercial(year, number, day) }
  rescue StandardError
    raise InvalidDates
  end
end
