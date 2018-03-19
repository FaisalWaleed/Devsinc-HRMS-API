class RoleSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :department

  def department
    object.department.name
  end
end