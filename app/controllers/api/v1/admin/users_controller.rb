class Api::V1::Admin::UsersController < ApplicationController
  before_action :set_user, only: [:update,:destroy]

  def index
    render :json => User.all
  end

  def update
    @user.update!(user_params)
    render :json => @user
  end

  def destroy
    if User.find(params[:id]).destroy
      render status: 200, json: {
          userId: params[:id],
          message: "Successfully deleted user"
      }
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:id,:name,:email,:username,:image,:company_id)
  end

end
