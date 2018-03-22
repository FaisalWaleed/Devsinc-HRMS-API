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
      refined_ticket_options.each do |ticket|
        params = ticket_params
        params = params.merge(user_id: current_user.id,department_id: ticket["department_id"], role_id: ticket["role_id"])
        @ticket = Ticket.create(params)
        if @ticket
          if @ticket.role_id == 0
            department = Department.find(ticket["department_id"])
            users = []
            department.roles.each do |role|
              users << role.users
            end
            assign_ticket_to_department_users(users,@ticket)
          else
            ticket["user_id"].each do |user|
              user = User.find(user)
              user.assigned_tickets << @ticket
            end
          end
          @ticket.set_statuses
        end
      end
    end

    render :json => {reached: "reached here"}
  end

  def update
    status = ticket_params[:status]
    if @ticket.user_id == current_user.id
      @ticket.ticket_user.each do |ticket_user|
        ticket_user.ticket_status.active.update_attributes({active: false})
        ticket_user.ticket_status <<
            TicketStatus.create(
                {
                    ticket_user_id: ticket_user.id,
                    status: status,
                    active: true
                }
            )
      end
    else
      ticket_user = @ticket.ticket_user.find_by(user_id: current_user.id)
      ticket_user.ticket_status.active.update_attributes({active: false})
      ticket_user.ticket_status <<
          TicketStatus.create(
              {
                  ticket_user_id: ticket_user.id,
                  status: status,
                  active: true
              }
          )

    end
    render :json => @ticket
  end

  def destroy
    if Ticket.find(params[:id]).destroy
      render status: 200, json: {
          userId: params[:id],
          message: "Successfully deleted ticket"
      }
    end
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

  private

  def set_ticket
    @ticket = Ticket.find(ticket_params[:id])
  end

  def ticket_params
    params.require(:ticket).permit(:id,:user_id,:title,:description,:status,:due_date)
  end

end
