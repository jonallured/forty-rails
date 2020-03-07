class TodayController < ApplicationController
  before_action :authenticate_user!
  expose(:props) do
    { dates: 'Feb 17-21, 2020' }
  end
end
