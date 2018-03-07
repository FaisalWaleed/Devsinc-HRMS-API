class CompanyDepartment < ApplicationRecord
  belongs_to :company
  belongs_to :department, dependent: :destroy
  validates_uniqueness_of :company, scope: :department
end
