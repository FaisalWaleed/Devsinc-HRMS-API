class ApplicationController < ActionController::API
  before_action :configure_permitted_parameters, if: :devise_controller?
  include DeviseTokenAuth::Concerns::SetUserByToken

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [
      :company_id,
      :username, 
      :name, 
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

end
