# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
print 'Creating Companies...'
companies = [
    { name: 'Devsinc', custom_domain: 'devsinc.com', subdomain: 'devsinc' }
].map { |c| print '.'; Company.find_or_create_by(c) }
puts "\n"

print 'Creating Departments...'
company = Company.first
departments = [
    { name: 'Account Owner', description: 'Account Owner' },
    { name: 'Administration', description: 'Department for Admins' },
    { name: 'Management', description: 'Department for Management' },
    { name: 'Software Engineering', description: 'Department of Software Engineering' },
    { name: 'Accounts Office', description: 'Department for Accounts' },
    { name: 'Human Resource', description: 'Department for Human Resource' },
    { name: 'Event Operations', description: 'Department for Event Operations' }
].map { |u| print '.'; company.departments.find_or_create_by!(u) { |m| m.assign_attributes(u) } }

print 'Creating Users'
pass = { password: 'pass1234', password_confirmation: 'pass1234' }
users = [
    { first_name: 'Jawad',last_name: 'Ali', email: 'admin@devsinc.com', company_id: companies[0].id, reporting_to: 1, buddy_id: 1, join_date: Date.new },
    { first_name: 'Jawad',last_name: 'Ali', email: 'jawad.firdous@devsinc.com', company_id: companies[0].id, reporting_to: 1, buddy_id: 1, join_date: Date.new},
    { first_name: 'Faisal',last_name: 'Ali', email: 'faisal.waleed@devsinc.com', company_id: companies[0].id,reporting_to: 1, buddy_id: 1, join_date: Date.new },
    { first_name: 'Salman',last_name: 'Ali', email: 'salman.ali@devsinc.com', company_id: companies[0].id , reporting_to: 1, buddy_id: 1, join_date: Date.new},
    { first_name: 'Usama',last_name: 'Ali', email: 'usama.kamran@devsinc.com', company_id: companies[0].id,reporting_to: 2, buddy_id: 2, join_date: Date.new},
    { first_name: 'Aqib',last_name: 'Ali', email: 'aqib.butt@devsinc.com', company_id: companies[0].id ,reporting_to: 2, buddy_id: 2, join_date: Date.new},
    { first_name: 'Usman',last_name: 'Ali', email: 'usman.asif@devsinc.com', company_id: companies[0].id ,reporting_to: 1, buddy_id: 1, join_date: Date.new  }
].map do |u|
  print '.'
  User.find_or_create_by!(u) { |u| u.assign_attributes(pass) }
end

account_owner_roles = [
    { title: 'Account Owner', department_id: 1}
].map do |r|
  print '.'
  Role.find_or_create_by!(r)
end



software_engineering_roles = [
    { title: 'Project Manager', department_id: 4 },
    { title: 'Software Engineer', department_id: 4 },
    { title: 'Associate Software Engineer', department_id: 4 },
].map do |r|
  print '.'
  Role.find_or_create_by!(r)
end

human_resource_roles = [
    { title: 'HR', department_id: 6 },
].map do |r|
  print '.'
  Role.find_or_create_by!(r)
end

############   Module UsersController/Devise Permissions
Permission.find_or_create_by(name: "users_index", description: "Manage Users Index Page", group: "Users", display_name: "View all Users" )
Permission.find_or_create_by(name: "users_update", description: "Update User", group: "Users", display_name: "Update User" )
Permission.find_or_create_by(name: "users_destroy", description: "Destroy User", group: "Users" , display_name: "Delete User" )
Permission.find_or_create_by(name: "registrations_create", description: "Create New User", group: "Users", display_name: "Create User" )
Permission.find_or_create_by(name: "users_show", description: "View User Profile", group: "Users", display_name: "View Profile")
Permission.find_or_create_by(name: "users_create", description: "Create New User ", group: "Users", display_name: "Invite New User")


############   Module DepartmentsController Permissions
Permission.find_or_create_by(name: "departments_index", description: "Departments Index Page", group: "Department", display_name: "View Departments")
Permission.find_or_create_by(name: "departments_create", description: "Create New Department", group: "Department", display_name: "Create Department")
Permission.find_or_create_by(name: "departments_update", description: "Update Department", group: "Department", display_name: "Update Departments")
Permission.find_or_create_by(name: "departments_show", description: "Show Department", group: "Department", display_name: "Show Departments")
Permission.find_or_create_by(name: "departments_destroy", description: "Delete Department", group: "Department", display_name: "Delete Departments")


############   Module RolesController Permissions
Permission.find_or_create_by(name: "roles_index", description: "Roles Index Page", group: "Roles", display_name: "View Roles")
Permission.find_or_create_by(name: "roles_create", description: "Create New Role", group: "Roles", display_name: "Create Role")
Permission.find_or_create_by(name: "roles_edit", description: "Edit Role", group: "Roles", display_name: "Edit Role")
Permission.find_or_create_by(name: "roles_update", description: "Update Role", group: "Roles", display_name: "Update Role")
Permission.find_or_create_by(name: "roles_destroy", description: "Delete Role", group: "Roles", display_name: "Delete Role")
Permission.find_or_create_by(name: "roles_show", description: "show Role", group: "Roles", display_name: "Show Role")
Permission.find_or_create_by(name: "roles_assignable_users", description: "Get Assignable Users", group: "Roles", display_name: "Show Assignable Users for role")
Permission.find_or_create_by(name: "roles_add_users", description: "Add User to Role", group: "Roles", display_name: "Assign Role to User")
Permission.find_or_create_by(name: "roles_remove_user", description: "Remove User from Role", group: "Roles", display_name: "Revoke Role from User")
############   Sub-Module RolesController  Permissions
Permission.find_or_create_by(name: "roles_allow_permission", description: "Can allow Permission", group: "Permissions" , display_name: "Can allow Permission")
Permission.find_or_create_by(name: "roles_revoke_permission", description: "Can revoke Permission", group: "Permissions" , display_name: "Can revoke Permission")


############   Module CommentsController Permissions
Permission.find_or_create_by(name: "comments_index", description: "Load Ticket Comments", group: "Comments" , display_name: "See Ticket Comments")
Permission.find_or_create_by(name: "comments_create", description: "Create Ticket Comments", group: "Comments" , display_name: "Create Ticket Comments")


############   Leaves LeavesStatusesController Permissions
Permission.find_or_create_by(name: "leave_statuses_create", description: "Create Leave Status", group: "Leaves", display_name: "Create Leave Status")
Permission.find_or_create_by(name: "leave_statuses_index", description: "Leave Life-cycle", group: "Leaves" , display_name: "Leave Life Cycle")


############   Leaves LeavesController Permissions
Permission.find_or_create_by(name: "leaves_index", description: "Leaves Index Page", group: "Leaves", display_name: "My Leaves")
Permission.find_or_create_by(name: "leaves_leave_approvals", description: "Leave Approvals", group: "Leaves", display_name: "Leave Approvals")
Permission.find_or_create_by(name: "leaves_create", description: "Create New Leave", group: "Leaves", display_name: "Create new Leave")
Permission.find_or_create_by(name: "leaves_user_leaves_history", description: "User Leave History", group: "Leaves", display_name: "User Leave History")


############   Module TicketsController  Permissions
Permission.find_or_create_by(name: "tickets_index", description: "Tickets Index Page", group: "Tickets", display_name: "View Tickets")
Permission.find_or_create_by(name: "tickets_assigned", description: "Assigned Tickets", group: "Tickets", display_name: "Assigned Tickets")
Permission.find_or_create_by(name: "tickets_create", description: "Create New Ticket", group: "Tickets", display_name: "Create Ticket")
Permission.find_or_create_by(name: "tickets_update", description: "Update Ticket", group: "Tickets", display_name: "Update Tickets")
Permission.find_or_create_by(name: "tickets_ticket_option", description: "Options For Tickets", group: "Tickets", display_name: "Add Ticket Options")
Permission.find_or_create_by(name: "tickets_statuses", description: "Tickets Statuses", group: "Tickets" , display_name: "View Ticket Statuses")

Role.find_by(title: 'Account Owner').permissions << Permission.all

User.first.roles << Role.find_by(title: 'Account Owner')
User.all.update(tokens: nil)