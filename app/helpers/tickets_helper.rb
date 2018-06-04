module TicketsHelper

  def all_deps_chosen? ticket_options
    ticket_options.each do |option|
      if option["department_id"] == 0
        return true
      end
    end
    false
  end

  def get_deps_with_all_roles ticket_options
    all_roles_chosen_deps = []
    ticket_options.each do |option|
      if option["role_id"] == 0
        all_roles_chosen_deps.push(option["department_id"])
      end
    end
    all_roles_chosen_deps
  end

  def refine_ticket_options ticket_options
    deps_with_all_roles = get_deps_with_all_roles ticket_options
    ticket_options.select { |option|
      (!option.empty?) &&
          (
          (deps_with_all_roles.include?(option["department_id"]) && option["role_id"] === 0) ||
              (!deps_with_all_roles.include?(option["department_id"]) && option["role_id"] != 0)
          )
    }
  end

  def assign_ticket_to_all_users ticket
    User.find_each do |user|
      if user != current_user
        user.assigned_tickets << ticket
        TicketMailer.ticket_assigned(ticket,user).deliver_later
      end
    end
  end

  def assign_ticket_to_users( users, ticket )
    users.each do |user|
      if user != current_user
        user.assigned_tickets << ticket
        TicketMailer.ticket_assigned(ticket,user).deliver_later
      end
    end
  end

  def change_ticket_status_for_all ( ticket, status )
    ticket.ticket_user.find_each do |ticket_user|
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
  end

  def change_ticket_status_for_user ( ticket, user, status )
    ticket_user = ticket.ticket_user.find_by(user_id: user.id)
    ticket_user.ticket_status.active.update_attribute(:active, false)
    ticket_user.ticket_status <<
        TicketStatus.create(
            {
                ticket_user_id: ticket_user.id,
                status: status,
                active: true
            }
        )
    TicketMailer.ticket_status_changed(ticket,user,status).deliver_later
  end
end
