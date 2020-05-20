class WorkDaysController < AuthenticatedController
  expose(:work_day, scope: -> { current_user.work_days })

  def update
    if work_day.update(work_day_params)
      render json: work_day
    else
      head :bad_request
    end
  end

  private

  def work_day_params
    permitted_fields = %i[adjust_minutes in_minutes out_minutes pto_minutes]
    params.require(:work_day).permit(permitted_fields)
  end
end
