class TodayController < ApplicationController
  def show
    target = Time.zone.today.strftime('%Y-%V')
    redirect_to work_week_path(target)
  end
end
