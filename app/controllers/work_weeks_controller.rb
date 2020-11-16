class WorkWeeksController < AuthenticatedController
  expose(:work_week) do
    year, number = params[:target].split('-')
    WorkWeek.find_or_create_by(user: current_user, year: year, number: number)
  end

  expose(:props) do
    {
      lastWeekPath: last_week_path,
      nextWeekPath: next_week_path,
      thisWeekPath: this_week_path,
      workWeek: work_week,
      user: current_user
    }
  end

  private

  def last_week_path
    target_date = work_week.target_date - 1.week
    target = TargetSlug.for(target_date)
    work_week_path(target)
  end

  def next_week_path
    target_date = work_week.target_date + 1.week
    target = TargetSlug.for(target_date)
    work_week_path(target)
  end

  def this_week_path
    target = TargetSlug.for(Time.zone.today)
    work_week_path(target)
  end
end
