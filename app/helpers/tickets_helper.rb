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
      User.all.each do |user|
        if user != current_user
          user.assigned_tickets << ticket
        end
    end
  end

  def assign_ticket_to_users( users, ticket )
    users.each do |user|
      if user != current_user
        user.assigned_tickets << ticket
      end
    end
  end

end
