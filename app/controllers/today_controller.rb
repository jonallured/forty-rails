class TodayController < ApplicationController
  def show
    today_target = Time.zone.today.strftime('%Y-%V')
    redirect_to "/work_weeks/#{today_target}"
  end
end
