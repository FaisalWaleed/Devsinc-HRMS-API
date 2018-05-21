class Api::V1::Admin::UsersController < ApplicationController
  before_action :set_user, only: [:update, :destroy, :show]

  def index
    render :json => User.all
  end

  def create
    params = user_params
    params.merge!(password: "pass1234", company_id: 1)
    @user = User.new(params)
    @user.save!
    @user.update(tokens: nil)
    unless @user.is_future_joining?
      @user.send_reset_password_instructions
    end
    render json: @user
  end


  def update
    @user.update!(user_params)
    render :json => @user
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
