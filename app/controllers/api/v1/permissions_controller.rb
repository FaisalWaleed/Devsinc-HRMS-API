class Api::V1::PermissionsController < ApplicationController
  before_action :authenticate_user!
  skip_before_action :is_authorized?

  def index
    render :json => {
        permissions: Permission.get_roles_permission(current_user.roles.pluck(:id)),
        roles: current_user.roles.pluck(:title)
    }
  end

  def get_permissions_obj
    render :json => Permission.get_permissions_obj
  end
end
