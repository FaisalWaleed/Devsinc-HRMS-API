class Api::V1::TicketsController < ApplicationController
  include TicketsHelper
  before_action :set_ticket, only: [:update,:destroy]
  # before_action :authenticate_user!

  def index
    # if admin
    #   return Ticket.all
    # end
    render :json => current_user.tickets
  end

  def assigned
    render :json => current_user.assigned_tickets
  end

  def create
    if all_deps_chosen? (params[:ticket][:ticket_options])
      merged_params = ticket_params.merge(user_id: current_user.id,department_id: 0,role_id: 0)
      @ticket = Ticket.create(merged_params)
      assign_ticket_to_all_users(@ticket)
      @ticket.set_statuses
    else
      refined_ticket_options = refine_ticket_options params[:ticket][:ticket_options]
      refined_ticket_options.each do |ticket_option|
        params = ticket_params
        params = params.merge(user_id: current_user.id,department_id: ticket_option["department_id"], role_id: ticket_option["role_id"])
        @ticket = Ticket.create(params)
        if ticket_option["role_id"] == 0
          department = Department.find(ticket_option["department_id"])
          department.roles.each do |role|
            assign_ticket_to_users(role.users,@ticket)
          end
        elsif ticket_option["user_id"].include? 0
          assign_ticket_to_users(Role.find(ticket_option["role_id"]).users,@ticket)
        else
          ticket_option["user_id"].each do |user|
            user = User.find(user)
            if user != current_user
              user.assigned_tickets << @ticket
            end
          end
        end
        @ticket.set_statuses
      end
    end
    render :json => {success: "Successfully created Ticket"}
  end

  def update
    status = ticket_params[:status]
    if @ticket.user_id == current_user.id
      if ticket_params[:ticket_user_id]
        ticket_user = TicketUser.find(ticket_params[:ticket_user_id])
        if ticket_user.ticket.user_id == current_user.id
          change_ticket_status_for_user(@ticket, nil , status, ticket_user)
        end
      else
        change_ticket_status_for_all(@ticket,status)
      end
    else
      change_ticket_status_for_user(@ticket, current_user.id, status)
    end
    render :json => @ticket
  end

  def ticket_option
    options = {department_id: params[:id]}
    options[:roles] = {}
    Department.find(params[:id]).roles.each do |role|
      options[:roles][role.id] =
          {
              :role_id => role.id,
              :role_name => role.title,
              :users => role.users.select(:id,:name)
          }
    end
    render :json => options
  end

  def statuses
    @ticket = Ticket.find(params[:ticket_id])
    render :json => @ticket.ticket_user
  end

  private

  def set_ticket
    @ticket = Ticket.find(params[:id])
  end

  def ticket_params
    params.require(:ticket).permit(:id,:user_id,:title,:description,:status,:due_date,:ticket_user_id)
  end

end
