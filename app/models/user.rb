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
  # belongs_to :department
  has_many :department_users
  has_many :users, through: :department_users
  has_many :department_users, autosave: true, dependent: :destroy
  has_many :users, through: :department_users
  has_many :ticket_user
  has_many :tickets, through: :ticket_user

  after_create :send_welcome_email

  def send_welcome_email
    UserMailer.welcome_email(self).deliver_now
  end
end
