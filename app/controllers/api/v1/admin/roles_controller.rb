module Api
  module V1
    module Admin
      class RolesController < ApplicationController
        wrap_parameters exclude: []
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

        def assignable_users
          assigned_users = Role.find(params[:role_id]).users.pluck(:id)
          render json: User.where.not(id: assigned_users), each_serializer: UserSelectSerializer
        end

        def add_users
          puts params.inspect
          role = Role.find(params[:role_id])
          if params[:role_users]
            params[:role_users].each do |ur|
              role.user_roles.find_or_create_by(user_id: ur["value"])
            end
          end
          render json: role
        end

        def remove_user
          role = Role.find(params[:role_id])
          role.user_roles.find_by(user_id: params[:user_id]).destroy
          render json: role
        end

        def allow_permission
          rp = RolePermission.find_or_create_by(role_id: role_params[:role_id], permission_id: role_params[:permission_id])
          render :json => { group: rp.permission.group, permission_id: rp.permission_id, role_id: rp.role_id }
        end

        def revoke_permission
          rp = RolePermission.find_by(role_id: role_params[:role_id], permission_id: role_params[:permission_id]).delete
          render :json => { group: rp.permission.group, permission_id: rp.permission_id, role_id: rp.role_id }
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
