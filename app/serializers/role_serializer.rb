class RoleSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :department_id
  has_many :users

  def department
    object.department_id
  end
end