class LeaveSerializer < ActiveModel::Serializer

  def status
    object.leave_statuses.last.status rescue nil
  end

  def username
    object.user.name
  end

  attributes :id,:username,:leave_type,:user_id,:reason,:start_date,:end_date,:status

end
