class Api::V1::LeaveStatusesController < ApplicationController

  def create
    params = leave_status_params.merge(user_id: current_user.id)
    @leave_status = LeaveStatus.create!(params)
  end

  def leave_status_params
    params.require(:leave_status).permit(:leave_id, :status, :user_id, :comment)
  end

  private
    def leave_status leave_id, status
      leave = Leave.find_by(leave_id: leave_id)
      if leave.user.reporting_to == current_user.id
        return status + "by Reporting to"
      else
        return status + "by HR"
      end
    end
end
