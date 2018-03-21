class Ticket < ApplicationRecord
  has_many :ticket_user
  has_many :users, through: :ticket_user
  has_many :ticket_status
  has_many :comments
  belongs_to :user

  after_create :set_status

  def set_status( status = "Open")
    previous_active = self.ticket_status.active
    previous_active.active = false
    previous_active.save!

    TicketStatus.create(
        {
            ticket_id: self.id,
            status: status,
            active: true
        }
    )
  end
end
