# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
print 'crecating companies '
companies = [
    { name: 'Devsinc', custom_domain: 'devsinc.com', subdomain: 'devsinc' }
].map { |c| print '.'; Company.find_or_create_by(c) }
puts "\n"

# print 'creating groups '
# groups = [
#   { name: 'Admin', group_type: 'admin', company_id: companies[0].id },
#   { name: 'Developer', group_type: 'developer', company_id: companies[0].id }
# ].map { |g| print '.'; Group.find_or_create_by(g) }
# puts "\n"

# roles = companies[0].user_roles.to_a
# admin = roles.select(&:super_admin?)
# roles -= admin

print 'Creating departments '
company = Company.first
departments = [
    { name: 'Super Admin', description: 'Super Admin for 1 tenant' },
    { name: 'Admin', description: 'Department for Admins' },
    { name: 'Management', description: 'Department for Managements' },
    { name: 'Accounts', description: 'Department for Accounts' },
    { name: 'Human Resource', description: 'Department for Human Resource' },
    { name: 'Management Information System', description: 'Department for Management Information System' },
    { name: 'Information Technology', description: 'Department for Information Technology' },
    { name: 'Event Operations', description: 'Department for Event Operations' }
].map { |u| print '.'; company.departments.find_or_create_by!(u) { |m| m.assign_attributes(u) } }

# print 'creating company departments'
# departments.map { |d| print '.'; Company.find(d.company_id).company_departments.find_or_create_by!(company_id: d.company_id, department_id: d.id) }

print 'creating users '
pass = { password: 'pass1234', password_confirmation: 'pass1234' }
users = [
    { name: 'Jawad Firdous', email: 'admin@devsinc.com', company_id: companies[0].id },
    { name: 'Faisal Waleed', email: 'faisal.waleed@devsinc.com', company_id: companies[0].id, reporting_to: 1 },
    { name: 'Salman Ali', email: 'salman.ali@devsinc.com', company_id: companies[0].id ,reporting_to: 2},
    { name: 'Usama Kamran', email: 'usama.kamran@devsinc.com', company_id: companies[0].id, reporting_to: 2},
    { name: 'Aqib Butt', email: 'aqib.butt@devsinc.com', company_id: companies[0].id ,reporting_to: 2},
    { name: 'Usman Asif', email: 'usman.asif@devsinc.com', company_id: companies[0].id ,reporting_to: 2 }
].map do |u|
  print '.'
  User.find_or_create_by!(u) { |u| u.assign_attributes(pass) }
end

Role.create(
    {
        title: 'Admin',
        department_id: 1
    }
)

Department.find(1).roles << Role.last
Role.last.users << User.find(1)
Role.last.users << User.find(2)

Role.create(
    {
        title: 'Project Manager',
        department_id: 1
    }
)

Department.find(1).roles << Role.last
Role.last.users << User.find(3)
Role.last.users << User.find(4)

Role.create(
    {
        title: 'Accountant',
        department_id: 2
    }
)

Department.find(2).roles << Role.last
Role.last.users << User.find(5)


# print 'creating department users '
# users.map { |u| print '.'; Department.find(u.department_id).department_users.find_or_create_by!(department_id: u.department_id, user_id: u.id) }

# group = Group.last
# user = User.last

# print 'creating group_members '
# group_members = [
#   { user_id: user.id, group_id: group.id }
# ].map { |gm| print '.'; GroupMember.find_or_create_by(gm) }
# group.documents.create(name: 'TestDocForGroup', creator_id: 2)
# user.documents.create(name: 'TestDocForUser', creator_id: 3)
# puts 'creating tickets '
# tickets = [
#   { title: 'salary', description: 'salary increase', status: 'assigned', reporter_id: 3, assignee_id: 5, user_role_id: 5 },
#   { title: 'work', description: 'i need to know the work flow', status: 'open', reporter_id: 3, user_role_id: 5 }
# ].map { |t| print '.'; Ticket.find_or_create_by(t) }


Permission.create(name: "users_index", description: "Manage Users Index Page", group: "Users", display_name: "View all Users" )
Permission.create(name: "users_destroy", description: "Destroy User", group: "Users" , display_name: "Delete User" )
Permission.create(name: "registrations_create", description: "Create New User", group: "Users", display_name: "Create User" )
Permission.create(name: "users_show", description: "View User Profile", group: "Users", display_name: "View Profile")


Permission.create(name: "departments_index", description: "Departments Index Page", group: "Department", display_name: "View Departments")
Permission.create(name: "departments_create", description: "Create New Department", group: "Department", display_name: "Create Department")


############   Module RolesConrtroller Permissions

Permission.create(name: "roles_index", description: "Roles Index Page", group: "Roles", display_name: "View Roles")
Permission.create(name: "roles_create", description: "Create New Role", group: "Roles", display_name: "Create Role")
Permission.create(name: "roles_edit", description: "Edit Role", group: "Roles", display_name: "Edit Role")
Permission.create(name: "roles_update", description: "Update Role", group: "Roles", display_name: "Update Role")
Permission.create(name: "roles_destroy", description: "Delete Role", group: "Roles", display_name: "Delete Role")
Permission.create(name: "roles_show", description: "show Role", group: "Roles", display_name: "Show Role")


############   Module TicketsController  Permissions


Permission.create(name: "tickets_index", description: "Tickets Index Page", group: "Tickets", display_name: "View Tickets")
Permission.create(name: "tickets_assigned", description: "Assigned Tickets", group: "Tickets", display_name: "Assigned Tickets")
Permission.create(name: "tickets_create", description: "Create New Ticket", group: "Tickets", display_name: "Create Ticket")
Permission.create(name: "tickets_update", description: "Update Ticket", group: "Tickets", display_name: "Update Tickets")
Permission.create(name: "tickets_ticket_option", description: "Options For Tickets", group: "Tickets", display_name: "Add Ticket Options")
Permission.create(name: "tickets_statuses", description: "Tickets Statuses", group: "Tickets" , display_name: "View Ticket Statuses")


############   Leaves LeavesController Permissions


Permission.create(name: "leaves_index", description: "Leaves Index Page", group: "Leaves", display_name: "My Leaves")
Permission.create(name: "leaves_leave_approvals", description: "Leave Approvals", group: "Leaves", display_name: "Leave Approvals")
Permission.create(name: "leaves_create", description: "Create New Leave", group: "Leaves", display_name: "Create new Leave")
Permission.create(name: "leaves_user_leaves_history", description: "User Leave History", group: "Leaves", display_name: "User Leave History")


############   Leaves LeavesStatusesController Permissions

Permission.create(name: "leave_statuses_create", description: "Create Leave Status", group: "Leaves", display_name: "Create Leave Status")
Permission.create(name: "leave_statuses_index", description: "Leave Life-cycle", group: "Leaves" , display_name: "Leave Life Cycle")

Permission.create(name: "roles_allow_permission", description: "Can allow Permission", group: "Permissions" , display_name: "Can allow Permission")
Permission.create(name: "roles_revoke_permission", description: "Can revoke Permission", group: "Permissions" , display_name: "Can revoke Permission")

Role.first.permissions << Permission.all

User.all.update(tokens: nil)