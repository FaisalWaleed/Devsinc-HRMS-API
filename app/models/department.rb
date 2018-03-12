class Department < ApplicationRecord
  has_many :department_users, autosave: true, dependent: :destroy
  has_many :users, through: :department_users
  has_many :company_departments
  has_many :companies, through: :company_departments
  accepts_nested_attributes_for :department_users, allow_destroy: true
end
