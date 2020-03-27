class WorkWeeksController < ApplicationController
  before_action :authenticate_user!

  expose(:work_week) do
    year, number = params[:target].split('-')
    WorkWeek.find_or_create_by(user: current_user, year: year, number: number)
  end

  expose(:props) do
    {
      dates: 'Feb 17-21, 2020',
      workWeek: work_week
    }
  end
end
