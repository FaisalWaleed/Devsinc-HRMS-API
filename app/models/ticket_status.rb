class TicketStatus < ApplicationRecord
  belongs_to :ticket

  scope :active, -> {find_by(active:true)}
end
