class Department < ApplicationRecord
  has_many :department_users, autosave: true, dependent: :destroy
  has_many :users, through: :department_users
  accepts_nested_attributes_for :department_users, allow_destroy: true
end
