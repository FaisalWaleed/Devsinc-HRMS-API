class TicketUser < ApplicationRecord
  belongs_to :ticket
  belongs_to :user
  has_many :ticket_status
end
