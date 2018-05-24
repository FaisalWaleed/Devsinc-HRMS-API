class ApplicationController < ActionController::API
  before_action :configure_permitted_parameters, if: :devise_controller?
  include DeviseTokenAuth::Concerns::SetUserByToken

  before_action :is_authorized?

  if Rails.env == 'production'
    rescue_from ActionController::RoutingError, with: :unprocessable_entity
    rescue_from ActiveRecord::RecordNotFound, with: :unprocessable_entity
    rescue_from ActionController::UnknownController, with: :unprocessable_entity
    rescue_from Exception, with: :unprocessable_entity
  end

  rescue_from ActiveRecord::RecordInvalid, with: :unprocessable_entity

  protected

  def unprocessable_entity(ex)
    # byebug
    render json: { errors: ex.message }, status: :unprocessable_entity
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [
      :company_id,
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
      :image,
      :join_date,
      :reporting_to,
      :buddy_id,
      :title,
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

  def is_account_owner? user
    user.roles.pluck(:title).include?("Account Owner")
  end

  def get_user_permissions
    Permission.get_roles_permission(current_user.roles.pluck(:id))
  end
end
