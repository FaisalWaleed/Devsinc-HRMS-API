class DepartmentUser < ApplicationRecord
  belongs_to :department
  belongs_to :user
  validates_uniqueness_of :department, scope: :user
end
