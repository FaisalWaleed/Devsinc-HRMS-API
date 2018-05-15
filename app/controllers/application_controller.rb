class ApplicationController < ActionController::API
  before_action :configure_permitted_parameters, if: :devise_controller?
  include DeviseTokenAuth::Concerns::SetUserByToken

  before_action :is_authorized?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [
      :company_id,
      :username,
      :first_name,
      :last_name,
      :contact_number,
      :secondary_contact_number,
      :emergency_contact_person_name,
      :emergency_contact_person_number,
      :emergency_contact_person_relation,
      :dob,
      :permanent_address,
      :temporary_address,
      :bank_account_number,
      :employment_history,
      :performance_evaluation,
      :image
      ] )
  end

  def get_controller_action
    controller_name+'_'+action_name
  end

  def is_authorized?
    request = get_controller_action
    permissions = get_user_permissions
    unless permissions.include? (request.to_s)
      render json: {
        error: "You aren't authorized for this action",
        status: 401
      }, status: 401
    end
  end

  def get_user_permissions
    Permission.get_roles_permission(current_user.roles.pluck(:id))
  end
end
