class Ticket < ApplicationRecord
  has_many :ticket_user
  has_many :users, through: :ticket_user
  has_many :comments
  belongs_to :user

  def set_statuses( status = "Open")

    self.ticket_user.each do |ticket_user|
      TicketStatus.create(
          {
              ticket_user_id: ticket_user.id,
              status: status,
              active: true
          }
      )
    end
  end


end
