class Department < ApplicationRecord
  has_many :company_departments
  has_many :companies, through: :company_departments
  has_many :roles
end
