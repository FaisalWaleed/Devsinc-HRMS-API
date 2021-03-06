class Api::V1::ConfirmationsController < DeviseTokenAuth::ConfirmationsController
  skip_before_action :is_authorized?, only: [:create,:new,:show]

  # GET /resource/confirmation/new
  # def new
  #   super
  # end

  # POST /resource/confirmation
  # def create
  #   super
  # end

  # GET /resource/confirmation?confirmation_token=abcdef
  # def show
  #   super
  # end

  # protected

  # The path used after resending confirmation instructions.
  # def after_resending_confirmation_instructions_path_for(resource_name)
  #   super(resource_name)
  # end

  # The path used after confirmation.
  def after_confirmation_path_for(resource_name, resource)
    puts '--------------------------------'
    puts resource_name.inspect
    puts resource.inspect
    puts '---------------------------------'
    super(resource_name, resource)
    sign_in(resource)
    "http://localhost:3001/dashboard"
  end
end
