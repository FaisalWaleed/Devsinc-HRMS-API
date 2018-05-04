class Api::V1::LeavesController < ApplicationController

  before_action :authenticate_user!

  def index
    render :json => current_user.leaves
  end

  def leave_approvals
    render :json => Leave.leave_approvals(current_user)
  end

  def create
    params = leave_params.merge(user_id: current_user.id)
    @leave = Leave.create(params)
    render :json => @leave
  end

  def user_leaves_history
    Leave.user_leaves_history(params[:user_id])
  end

  private

  def set_leave
    @leave = Leave.find(params[:id])
  end

  def leave_params
    params.require(:leave).permit(:id,:leave_type,:reason,:start_date,:end_date)
  end
end
