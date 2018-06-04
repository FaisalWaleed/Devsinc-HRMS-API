class Api::V1::LeaveStatusesController < ApplicationController

  def create
    params = leave_status_params.merge(user_id: current_user.id)
    params[:status] = leave_status_params[:status]
    @leave_status = LeaveStatus.create!(params)
    LeaveMailer.leave_status_changed(@leave_status).deliver_later unless @leave_status.status == "pending"
    LeaveMailer.hr_leave_approved(@leave_status).deliver_later if @leave_status.status == "approved"
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

  def leave_status_params
    params.require(:leave_status).permit(:leave_id, :status, :user_id, :comment)
  end
end
