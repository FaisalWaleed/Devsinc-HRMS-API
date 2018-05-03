class Leave < ApplicationRecord
  belongs_to :user
  has_many :leave_statuses

  after_create :set_leave_status

  private

  scope :leave_approvals, ->(user) {
    self.joins(:user).where("users.reporting_to= ?" , user.id)
  }


  def set_leave_status
    LeaveStatus.create({leave_id: self.id, status: "pending", active: true })
  end


  def HR_Leaves
    Leave.joins(:leave_statuses).where.not("leave_statuses.status='pending' OR leave_statuses.status='Approved'")
  end

end
