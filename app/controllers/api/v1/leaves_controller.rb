class Api::V1::LeavesController < ApplicationController
  before_action :authenticate_user!
  include LeavesHelper

  def index
    render :json => current_user.leaves
  end

  def all_leaves
    render :json => Leave.all
  end

  def leave_approvals
    leaves = Leave.leave_approvals(current_user)
    render :json => (leaves.uniq)
  end

  def create
    params = leave_params.merge(user_id: current_user.id)
    @leave = Leave.create(params)
    render :json => @leave
  end

  def user_leaves_history
    user = User.find(params[:user_id])
    render :json =>
               {
                   user_id: user.id,
                   year: get_year_leaves(user),
                   month: get_month_leaves(user),
                   quota: 14
               }
  end

  private

  def set_leave
    @leave = Leave.find(params[:id])
  end

  def leave_params
    params.require(:leave).permit(:id,:leave_type,:reason,:start_date,:end_date)
  end
end
