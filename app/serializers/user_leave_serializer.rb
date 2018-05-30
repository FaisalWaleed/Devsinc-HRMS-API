class UserLeaveSerializer < ActiveModel::Serializer
  attributes :id,
             :name,
             :month_leaves,
             :year_leaves,
             :remaining_leaves

  def name
    "#{object.first_name} #{object.last_name}"
  end

  def remaining_leaves
    (14-object.year_leaves) < 0 ? 0 : 14-object.year_leaves
  end
end
