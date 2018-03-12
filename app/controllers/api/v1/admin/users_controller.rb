class Api::V1::Admin::UsersController < ApplicationController

  def index
    render :json => User.select(:id,:email,:name,:username,:image,:company_id)
  end

  def update
    @user = User.find(params[:id])
    @user.name = params[:name]
    @user.username = params[:username]
    @user.email = params[:email]
    @user.company_id = params[:company_id]
    @user.save!
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
end
