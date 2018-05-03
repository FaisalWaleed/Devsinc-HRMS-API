class LeaveSerializer < ActiveModel::Serializer

  def status
    object.leave_statuses.last.status rescue nil
  end

  attributes :leave_type,:reason,:start_date,:end_date,:status

end
