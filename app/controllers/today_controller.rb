class TodayController < ApplicationController
  def show
    target = TargetSlug.for(Time.zone.today)
    redirect_to work_week_path(target)
  end
end
