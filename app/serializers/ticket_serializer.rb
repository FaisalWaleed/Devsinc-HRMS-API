class TicketSerializer < ActiveModel::Serializer

  def status
    object.ticket_status.active.status
  end

  attributes :id,:title,:description,:due_date,:status

end
