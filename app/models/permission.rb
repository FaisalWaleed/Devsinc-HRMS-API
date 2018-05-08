class Permission < ApplicationRecord
  has_many :role_permissions
  has_many :roles, through: :role_permissions

  def self.get_roles_permission roles
    Permission.joins(:roles).where("roles.id IN (?)", roles).pluck(:name)
  end
end
