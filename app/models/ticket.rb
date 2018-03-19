class Ticket < ApplicationRecord
  has_many :ticket_user
  has_many :users, through: :ticket_user
end
