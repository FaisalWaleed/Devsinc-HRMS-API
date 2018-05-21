class Api::V1::SessionsController < DeviseTokenAuth::SessionsController
  skip_before_action :is_authorized?, only: [:create,:new,:destroy]

  # GET /resource/sign_in
  def new
    super
  end

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
    render :json => {data: @resource, permissions: "Put permissions here"}, :status => 200
  end


end
