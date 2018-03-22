class User < ActiveRecord::Base
  # Include default devise modules.
  devise :database_authenticatable, :registerable,
          :recoverable, :rememberable, :trackable, :validatable,
          :omniauthable

  include DeviseTokenAuth::Concerns::User

  validates :company_id, presence: true

  belongs_to :company
  has_many :user_roles
  has_many :roles, through: :user_roles
  has_many :ticket_user
  has_many :assigned_tickets, through: :ticket_user, source: :ticket
  has_many :tickets

  after_create :send_welcome_email

  def send_welcome_email
    UserMailer.welcome_email(self).deliver_now
  end
end
