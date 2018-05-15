class Api::V1::Admin::UsersController < ApplicationController
  before_action :set_user, only: [:update, :destroy, :show]

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

  def show
    render json: @user
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(
      :id,
      :email,
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
      :performance_evaluation,
      :image,
      :reporting_to,
      :employment_history => [:role , :from, :to],
      )
  end

end
