class Api::V1::LeavesController < ApplicationController
  before_action :authenticate_user!
  include LeavesHelper

  def index
    render :json => current_user.leaves
  end

  def all_leaves
    month_leaves = "COALESCE((SELECT SUM(month_details.total_days) FROM (SELECT ((leaves.end_date::date - leaves.start_date::date)+1) as total_days FROM leaves JOIN leave_statuses on leaves.id = leave_statuses.leave_id WHERE leaves.user_id=users.id AND leave_statuses.status='approved' AND leaves.start_date >= date_trunc('month', current_date))month_details ),0) as month_leaves"
    year_leaves = "COALESCE((SELECT SUM(month_details.total_days) FROM (SELECT ((leaves.end_date::date - leaves.start_date::date)+1) as total_days FROM leaves JOIN leave_statuses on leaves.id = leave_statuses.leave_id WHERE leaves.user_id=users.id AND leave_statuses.status='approved' AND leaves.start_date >= date_trunc('year', current_date ))month_details ),0) as year_leaves"
    all_user_leaves = User.joins(:leaves).select("users.id,users,first_name,users.last_name,#{month_leaves},#{year_leaves}").group("users.id").to_a
    render :json => all_user_leaves, each_serializer: UserLeaveSerializer
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
