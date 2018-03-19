module Api
  module V1
    module Admin
      class RolesController < ApplicationController
        wrap_parameters :role
        before_action :set_department, only: [:create]

        def index
          roles = Role.all
          render json: roles
        end

        def create
          render json: @department.roles.create!(role_params)
        end

        def update
          role.update!(role_params)
          render json: role
        end

        def show
          render json: Role.find(params[:id])
        end

        def destroy
          render json: Role.find(params[:id]).destroy!
        end

        private

        def role_params
          params.require(:role).permit(:id, :title, :description, :department_id)
        end

        def role
          @role ||= Role.find(params[:id])
        end

        def set_department
          @department = Department.find(params[:department_id])
        end

      end
    end
  end
end
