module Api
  module V1
    module Admin
      class DepartmentsController < ApplicationController
        wrap_parameters :department
        before_action :set_company

        def index
          departments = Department.all
          render json: departments
        end

        def create
          render json: @company.departments.create!(department_params)
        end

        def update
          department.update!(department_params)
          render json: department
        end

        def show
          render json: Department.find(params[:id])
        end

        def destroy
          render json: @company.company_departments.find_by(department_id: params[:id]).destroy!
        end

        private

        def department_params
          params.require(:department).permit(:id, :name, :description, :position)
        end

        def department
          @department ||= Department.find(params[:id])
        end

        def set_company
          @company = Company.first
        end
      end
    end
  end
end
