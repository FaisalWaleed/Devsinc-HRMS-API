class Leave < ApplicationRecord
  belongs_to :user
  has_many :leave_statuses

end
