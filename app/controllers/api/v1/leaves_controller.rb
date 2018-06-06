class Api::V1::LeavesController < ApplicationController
  before_action :authenticate_user!
  include LeavesHelper

  def index
    render :json => current_user.leaves
  end

  def all_leaves
    sick_leaves = "COALESCE((SELECT SUM(month_details.total_days) FROM (SELECT ((leaves.end_date::date - leaves.start_date::date)+1) as total_days FROM leaves JOIN leave_statuses on leaves.id = leave_statuses.leave_id WHERE leaves.user_id=users.id AND leave_statuses.status='approved' AND leaves.start_date >= date_trunc('year', current_date) AND leaves.leave_type='sick' )month_details ),0) as sick_leaves"
    annual_leaves = "COALESCE((SELECT SUM(month_details.total_days) FROM (SELECT ((leaves.end_date::date - leaves.start_date::date)+1) as total_days FROM leaves JOIN leave_statuses on leaves.id = leave_statuses.leave_id WHERE leaves.user_id=users.id AND leave_statuses.status='approved' AND leaves.start_date >= date_trunc('year', current_date ) AND leaves.leave_type='annual' )month_details ),0) as annual_leaves"
    compensation_leaves = "COALESCE((SELECT SUM(month_details.total_days) FROM (SELECT ((leaves.end_date::date - leaves.start_date::date)+1) as total_days FROM leaves JOIN leave_statuses on leaves.id = leave_statuses.leave_id WHERE leaves.user_id=users.id AND leave_statuses.status='approved' AND leaves.start_date >= date_trunc('year', current_date ) AND leaves.leave_type='compensation' )month_details ),0) as compensation_leaves"
    all_user_leaves = User.joins(:leaves).select("users.id as user_id,users.first_name,users.last_name,#{sick_leaves},#{annual_leaves},#{compensation_leaves}").group("users.id").to_a
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
                   annual: get_year_leaves(user).where(leave_type: "annual").count,
                   sick: get_year_leaves(user).where(leave_type: "sick").count,
                   compensation: get_year_leaves(user).where(leave_type: "compensation").count,
               }
  end

  def get_user_leaves
    render json: User.find(params[:id]).leaves
  end

  private

  def set_leave
    @leave = Leave.find(params[:id])
  end

  def leave_params
    params.require(:leave).permit(:id,:leave_type,:reason,:start_date,:end_date)
  end
end
