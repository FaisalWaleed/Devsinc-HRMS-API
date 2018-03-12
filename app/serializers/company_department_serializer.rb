class CompanyDepartmentSerializer < ActiveModel::Serializer
  # attributes :department
  belongs_to :department
  # def department
  #   Department.find(self.department_id)
  # end
end