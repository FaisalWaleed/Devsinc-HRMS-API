class TicketStatus < ApplicationRecord
  belongs_to :ticket_user
  scope :active, -> {find_by(active:true)}
end
