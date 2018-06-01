class LeaveMailer < ApplicationMailer

  def leave_status_changed(leave_status)
    @user = leave_status.leave.user
    @approved_by = leave_status.user
    @leave = leave_status.leave
    @status = leave_status.status
    mail(to: @user.email, subject: "Your Leave has been #{@status}!")
  end

  def hr_leave_approved(leave_status)
    @user = leave_status.leave.user
    @approved_by = leave_status.user
    @leave = leave_status.leave
    @date_diff = (@leave.end_date - @leave.start_date).to_i + 1
    mail(to: "hr@devsinc.com", subject: "#{@approved_by.name} approved #{@user.name}'s Leave for #{@date_diff} days ")
  end
end
