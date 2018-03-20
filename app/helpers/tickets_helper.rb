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
      unless option["role"]
        all_roles_chosen_deps.push(option["department"])
      end
    end
    all_roles_chosen_deps
  end

  def refine_ticket_options ticket_options
    deps_with_all_roles = get_deps_with_all_roles ticket_options
    ticket_options.select { |option|
      (!option.empty?) &&
          (
          (deps_with_all_roles.include?(option["department"]) && option["role"] === 0) ||
              (!deps_with_all_roles.include?(option["department"]) && option["role"] != 0)
          )
    }
  end

  def assign_ticket_to_all_users ticket
    if ticket
      User.all.each do |user|
        user.assigned_tickets << ticket
      end
    end
  end

  def assign_ticket_to_department_users( users, ticket )
    #   SELECT user_roles.user_id FROM roles JOIN user_roles ON user_roles.role_id=roles.id WHERE roles.department_id = 1
    users.each do |user|
      user.assigned_tickets << ticket
    end
  end

end
