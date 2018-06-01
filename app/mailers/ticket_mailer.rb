class TicketMailer < ApplicationMailer

  def ticket_assigned(ticket, user)
    @user = user
    @assignee = ticket.user
    @ticket = ticket
    mail(to: @user.email, subject: "#{@assignee.name} assigned you a new Ticket!")
  end

end
