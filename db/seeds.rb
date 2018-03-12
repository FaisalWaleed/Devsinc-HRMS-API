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
  { email: 'admin@devsinc.com', company_id: companies[0].id, department_id: departments[0].id },
  { email: 'user2@devsinc.com', company_id: companies[0].id, department_id: departments[6].id },
  { email: 'user3@devsinc.com', company_id: companies[0].id, department_id: departments[6].id },
  { email: 'user4@devsinc.com', company_id: companies[0].id, department_id: departments[6].id },
  { email: 'user5@devsinc.com', company_id: companies[0].id, department_id: departments[6].id },
  { email: 'user6@devsinc.com', company_id: companies[0].id, department_id: departments[6].id }
].map do |u|
  print '.'
  User.find_or_create_by!(u) { |u| u.assign_attributes(pass) }
end

print 'creating department users '
users.map { |u| print '.'; Department.find(u.department_id).department_users.find_or_create_by!(department_id: u.department_id, user_id: u.id) }

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
