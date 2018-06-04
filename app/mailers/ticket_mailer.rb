class TicketMailer < ApplicationMailer

  def ticket_assigned(ticket, user)
    @user = user
    @assignee = ticket.user
    @ticket = ticket
    mail(to: @user.email, subject: "#{@assignee.name} assigned you a new Ticket!")
  end

  def ticket_status_changed(ticket,user,status)
    @ticket = ticket
    @assignee = ticket.user
    @user = user
    @status = status
    mail(to: @assignee.email, subject: "#{@user.name} marked '#{ticket.title}' as #{@status} ")
  end

end
