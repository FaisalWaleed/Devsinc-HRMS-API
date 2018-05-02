class Leave < ApplicationRecord
  belongs_to :user
  has_many :leave_statuses

  after_create :set_leave_status

  private

  scope :leave_approvels, ->(user) {
    self.joins(:user).where("users.reporting_to= ?" , user.id)
  }


  def set_leave_status
    LeaveStatus.create({leave_id: self.id, status: "pending", active: true, changed_by_user_id: self.user.id })
  end

end
