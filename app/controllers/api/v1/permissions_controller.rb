class Api::V1::PermissionsController < ApplicationController
  before_action :authenticate_user!
  # skip_before_action :is_authorized?

  def index
    render :json => Permission.get_roles_permission(current_user.roles.pluck(:id))
  end

  def get_permissions_obj
    obj = {}
    Permission.all.each do |permission|
      if obj[permission.group].kind_of?(Array)
        obj[permission.group].push({
                                       permission_id: permission.id,
                                       permission_display: permission.display_name,
                                       allowed_for: permission.roles.pluck(:id)
                                   })
      else
        obj[permission.group] = [{
                                     permission_id: permission.id,
                                     permission_display: permission.display_name,
                                     allowed_for: permission.roles.pluck(:id)
                                 }
        ]
      end
    end

    render :json => obj

  end
end
