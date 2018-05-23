class Api::V1::Admin::UsersController < ApplicationController
  before_action :set_user, only: [:update, :destroy, :show]

  def index
    render :json => User.all
  end

  def create
    params = user_params
    params.merge!(password: "pass1234", company_id: 1)
    @user = User.new(params)
    if @user.save
      @user.update(tokens: nil)
      basic_role = Role.find_by(title: "New Hiring")
      @user.roles << basic_role if basic_role.present?
      unless @user.is_future_joining?
        SendMailOnUserCreationJob.perform_later(@user)
      end
      render json: @user
    else
      render json: {alert: "Error Occurred",  status: 500}

    end
  end


  def update
    if params[:user][:id].to_i == current_user.id || is_account_owner?(current_user)
      @user = User.find(params[:user][:id])
      if @user.present? && @user.update_attributes(user_params)
        render :json => @user
      else
        render json: {message: "Error in Updating Profile" , status: 500}
      end
    else
      render json: { message: "Unauthorized" , status: 401 }
    end
  end

  def destroy
    if @user.destroy
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
        :title
    )
  end

end
