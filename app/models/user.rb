class User < ActiveRecord::Base
  # Include default devise modules.
  devise :database_authenticatable, :registerable,
          :recoverable, :rememberable, :trackable, :validatable,
          :omniauthable

  include DeviseTokenAuth::Concerns::User

  validates_format_of :email, with: /[A-Z0-9._%+-]+@devsinc.com/i
  validates :last_name, presence: true
  validates :first_name, presence: true
  validates :email, presence: true
  validates :email, uniqueness: true
  validates :join_date, presence: true
  validates :reporting_to, presence: true
  # validates :company_id, presence: true

  # belongs_to :company
  has_many :user_roles
  has_many :roles, through: :user_roles
  has_many :ticket_user
  has_many :assigned_tickets, through: :ticket_user, source: :ticket
  has_many :tickets
  has_many :leaves
  # belongs_to  :buddy , class_name: "User", foreign_key: "buddy_id"
  # belongs_to  :reports_to , class_name: "User", foreign_key: "reporting_to"


  # after_create :send_welcome_email

  mount_uploader :image, ImageUploader



  def send_welcome_email
    UserMailer.welcome_email(self).deliver_now
  end

  def name
    self.first_name + " " + self.last_name
  end

  def reports_to
    User.find(self.reporting_to)
  end

  def is_future_joining?
    self.join_date > Date.today
  end
end
