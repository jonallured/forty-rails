class WorkWeek < BaseWorkWeek
  def find_or_create
    self.work_days = dates.map do |date|
      user.work_days.find_or_create_by!(date: date)
    end
  end

  private

  def week_to_date_ids
    days = work_days.select { |day| day.date <= Time.zone.today }
    days.map(&:id)
  end
end
