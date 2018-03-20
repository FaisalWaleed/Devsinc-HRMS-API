class Api::V1::TicketsController < ApplicationController
  include TicketsHelper
  before_action :set_ticket, only: [:update,:destroy]

  def index
    # if admin
    #   return User.all
    # end
    current_user.inspect
    render :json => current_user.tickets
  end

  def assigned
    render :json => current_user.assigned_tickets
  end

  def create
    if all_deps_chosen? (params[:ticket][:ticket_options])
      params = ticket_params.merge(department_id: 0,role_id: 0)
      @ticket = Ticket.create(params)
      assign_ticket_to_all_users(@ticket)
    else
      ticket_options = refine_ticket_options params[:ticket][:ticket_options]
      ticket_options.each do |ticket|
        params = ticket_params
        params = params.merge(department_id: ticket["department_id"], role_id: ticket["role_id"])
        @ticket = Ticket.create(params)
        if @ticket
          if !@ticket.role_id
            department = Department.find(ticket["department_id"])
            users = []
            department.roles.each do |role|
              users << role.users
            end
            assign_ticket_to_department_users(users,@ticket)
          else
            ticket["user_id"].each do |user|
              user = User.find(user)
              user.assigned_ticket << @ticket
            end
          end
        end
      end
    end

    render :json => {reached: "reached here"}
  end

  def update
    @ticket.update!(ticket_params)
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

  private

  def set_ticket
    @ticket = Ticket.find(params[:id])
  end

  def ticket_params
    params.require(:ticket).permit(:id,:user_id,:title,:description,:status,:due_date)
  end

end
