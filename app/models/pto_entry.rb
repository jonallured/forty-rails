class PtoEntry
  def initialize(work_day)
    @work_day = work_day
  end

  def listing
    minutes = @work_day.pto_minutes
    time = FortyTime.parse(minutes)
    date = @work_day.date.strftime('%m/%d')
    [date, time.to_s].join('-')
  end

  def target
    TargetSlug.for(@work_day.date)
  end
end
