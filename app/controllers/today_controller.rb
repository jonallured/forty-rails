class TodayController < ApplicationController
  before_action :authenticate_user!

  def show
    render plain: 'today'
  end
end
