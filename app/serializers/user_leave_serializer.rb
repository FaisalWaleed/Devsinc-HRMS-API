class UserLeaveSerializer < ActiveModel::Serializer
  attributes :user_id,
             :name,
             :sick_leaves,
             :annual_leaves,
             :compensation_leaves

  def name
    "#{object.first_name} #{object.last_name}"
  end
end
