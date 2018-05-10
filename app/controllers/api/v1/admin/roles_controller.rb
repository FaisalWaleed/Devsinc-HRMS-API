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

        def allow_permission
          RolePermission.find_or_create_by(role_id: role_params[:role_id], permission_id: role_params[:permission_id])
        end

        def revoke_permission
          RolePermission.find_by(role_id: params[:role_id], permission_id: params[:permission_id]).delete
        end

        private

        def role_params
          params.require(:role).permit(:id, :title, :description, :department_id, :role_id, :permission_id)
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
