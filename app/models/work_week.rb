class WorkWeek
  class InvalidDates < StandardError; end

  attr_reader :work_days

  def self.find_or_create_by(user:, year:, number:)
    work_week = new(user, year, number)
    work_week.find_or_create
    work_week
  rescue InvalidDates # rubocop:disable Lint/SuppressedException
    # year and/or number failed to parse as valid date
  end

  def initialize(user, year, number)
    @user = user
    @year = year.to_i
    @number = number.to_i
    @work_days = []
  end

  def find_or_create
    @work_days = dates.map do |date|
      @user.work_days.find_or_create_by!(date: date)
    end
  end

  def as_json(_)
    {
      workDays: @work_days
    }
  end

  private

  def dates
    raise InvalidDates unless @year.positive? && @number.positive?

    @dates ||= (1..5).map { |day| Date.commercial(@year, @number, day) }
  rescue StandardError
    raise InvalidDates
  end
end
