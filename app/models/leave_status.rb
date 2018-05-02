class LeaveStatus < ApplicationRecord
  belongs_to :leave
  belongs_to :user, :foreign_key => 'changed_by_user_id'

  scope :active, -> {find_by(active:true)}

end
