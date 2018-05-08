class Api::V1::SessionsController < DeviseTokenAuth::SessionsController
  skip_before_action :is_authorized?, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  def create
    super
  end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end

  protected
  def render_create_success
    resource = @resource.as_json.merge({permissions: "Put User Permissions Here"})
    render :json => resource
  end


end
