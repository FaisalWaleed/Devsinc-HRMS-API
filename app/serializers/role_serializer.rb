class RoleSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :department_id, :department
  has_many :users

  def department
    object.department.name
  end
end