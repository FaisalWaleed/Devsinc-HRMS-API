class Api::V1::LeaveStatusesController < ApplicationController

  def create
    params = leave_status_params.merge(user_id: current_user.id)
    params[:status] = leave_status(leave_status_params[:leave_id], leave_status_params[:status])
    @leave_status = LeaveStatus.create!(params)
    render :json => @leave_status
  end

  def index
    render :json =>
               {
                   leave_id: params[:leave_id],
                   lifecycle: Leave.find(params[:leave_id]).leave_statuses
               }
  end

  private

  def leave_status leave_id, status
    leave = Leave.find(leave_id)
    if leave.user.reporting_to == current_user.id
      return status + " by Reporting to"
    else
      return status + " by HR"
    end
  end

  def leave_status_params
    params.require(:leave_status).permit(:leave_id, :status, :user_id, :comment)
  end
end
