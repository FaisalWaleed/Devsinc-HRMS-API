module Api
  module V1
    module Admin
      class DepartmentsController < ApplicationController
        wrap_parameters :department, include: %i[name description position company_id created_at updated_at]

        def index
          departments = Department.all
          render json: departments
        end

        def create
          render json: Ddepartment.create!(department_params)
        end

        # def update
        #   department.update!(department_params)
        #   respond_with department
        # end

        # def destroy
        #   current_company.company_departments.find_by(department_id: params[:id]).destroy!
        # end

        private

        def department_params
          params.require(:department).permit(:id, :name, :description, :position).merge(company_id: current_company.id)
        end

        def department
          @department ||= Department.find(params[:id])
        end
      end
    end
  end
end
