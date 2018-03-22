class TicketSerializer < ActiveModel::Serializer

  def status
    # get ticket user,get ticket status, get active ticket status, get status field
    object.ticket_user.find_by(user_id: current_user.id).ticket_status.active.status
  end

  attributes :id,:title,:description,:due_date,:status

end
