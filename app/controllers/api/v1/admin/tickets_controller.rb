class Api::V1::Admin::TicketsController < ApplicationController
  include TicketsHelper
  before_action :set_ticket, only: [:update,:destroy]

  def index
    render :json => Ticket.all
  end

  def create
    if all_deps_chosen? params[:ticket][:ticket_options]
      params = ActionController::Parameters.new(ticket_params)
      params = params.merge(department_id: 0,role_id: 0)
      @ticket = Ticket.create(params)

      User.all.each do |user|
        user.tickets << @ticket
      end

    else
      tickets = refine_ticket_options params[:ticket][:ticket_options]
      tickets.each do |ticket|
        #tickets = [
        # {department:1,role:4,user:[5,3,2,9]}
        # {department:5,role:9,user:[14,22,44,12]}
        # ]
        params = ActionController::Parameters.new(ticket_params)
        params = params.merge(department_id: ticket["department"], role_id: ticket["role"])
        @ticket = Ticket.create(params)

        if @ticket.role_id == 0
          #fetch all users of department_id and assign them ticket
          # or users array should have all user ids
        else
          ticket["user"].each do |user|
            user = User.find(user)
            user.tickets << @ticket
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
    params.require(:ticket).permit(:id,:title,:description,:status,:due_date)
  end

end
