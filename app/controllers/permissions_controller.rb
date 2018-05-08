class PermissionsController < ApplicationController
  before_action :authenticate_user!
  skip_before_action :is_authorized?

  def index
    Permission.get_roles_permission(current_user.roles.pluck(:id))
  end
end
