class TicketSerializer < ActiveModel::Serializer

  def status
    object.ticket_user.find_by(user_id: current_user.id) ?
        object.ticket_user.find_by(user_id: current_user.id).ticket_status.active.status :
        nil
  end

  def overall_status
    if object.user_id == current_user.id
      object.ticket_user.each do |ticket_user|
        if ticket_user.ticket_status.active.status == "In Progress" || ticket_user.ticket_status.active.status == "Open"
          return "In Progress"
        end
      end
      return "Closed"
    else
      nil
    end
  end

  attributes :id,:title,:description,:due_date,:status,:overall_status

end
