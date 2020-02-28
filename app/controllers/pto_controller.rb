class PtoController < ApplicationController
  expose(:pto_report) { PtoReport.generate_for(current_user, params[:year]) }

  def index
    year = Time.zone.today.year
    redirect_to pto_report_path(year)
  end
end
