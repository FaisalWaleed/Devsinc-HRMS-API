class Permission < ApplicationRecord
  has_many :role_permissions
  has_many :roles, through: :role_permissions

  def self.get_roles_permission roles
    Permission.joins(:roles).where("roles.id IN (?)", roles).pluck(:name)
  end

  def self.get_permissions_obj
    obj = {}
    Permission.all.each do |permission|
      unless obj[permission.group].kind_of?(Hash)
        obj[permission.group]= {}
      end
      obj[permission.group][permission.id]=
          {
              permission_display: permission.display_name,
              allowed_for: permission.roles.pluck(:id)
          }
    end
    obj
  end
end
