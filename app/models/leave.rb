class Leave < ApplicationRecord
  belongs_to :user
  has_many :leave_statuses

  after_create :set_leave_status

  private

  scope :leave_approvals, ->(user) {
    self.joins(:user).where("users.reporting_to= ?" , user.id)
  }


  scope :this_year, -> {
    self.where("leaves.start_date > ?" , Time.now.beginning_of_year)
  }

  scope :this_month, -> {
    self.where("leaves.start_date > ? AND start_date < ?" , Time.now.beginning_of_month, Time.now.end_of_month)
  }

  after_create :set_leave_status

  def hr_leaves
    Leave.joins(:leave_statuses).where.not("leave_statuses.status='pending' OR leave_statuses.status='Approved'")
  end

  private

  def set_leave_status
    LeaveStatus.create({leave_id: self.id, status: "pending", user_id: self.user.id })
  end

end
