class TargetSlug
  def self.for(date)
    year = date.cwyear
    week = date.strftime('%V')
    [year, week].join('-')
  end
end
