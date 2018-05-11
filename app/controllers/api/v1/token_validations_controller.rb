class Api::V1::TokenValidationsController < DeviseTokenAuth::TokenValidationsController
  skip_before_action :is_authorized?, only: [:validate_token]

  def validate_token
    super
  end


end
