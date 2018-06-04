class TicketSerializer < ActiveModel::Serializer

  attributes :id,:title,:description,:due_date,:status,:overall_status, :created_by, :created_at

  def status
    object.ticket_user.find_by(user_id: current_user.id) ?
        object.ticket_user.find_by(user_id: current_user.id).ticket_status.active.status :
        nil
  end

  def overall_status
    if object.user_id == current_user.id || current_user.has_permission?("tickets_all_tickets") #handle for has admin perms
      overall_status = {
          open: [],
          closed: [],
          completed: []
      }
      object.ticket_user.each do |ticket_user|
        if(ticket_user.ticket_status.active.status == "Open")
          overall_status[:open].push(User.find(ticket_user.user_id).name)
        elsif(ticket_user.ticket_status.active.status == "Closed")
          overall_status[:closed].push(User.find(ticket_user.user_id).name)
        elsif(ticket_user.ticket_status.active.status == "Completed")
          overall_status[:completed].push(User.find(ticket_user.user_id).name)
        end
      end
      overall_status
    else
      nil
    end
  end

  def created_by
    object.user.name
  end

end
