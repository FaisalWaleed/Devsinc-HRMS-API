class User < ActiveRecord::Base
  # Include default devise modules.
  devise :database_authenticatable, :registerable,
          :recoverable, :rememberable, :trackable, :validatable,
          :omniauthable

  include DeviseTokenAuth::Concerns::User

  validates :company_id, presence: true

  belongs_to :company
  # belongs_to :department
  has_many :department_users
  has_many :users, through: :department_users
  has_many :department_users, autosave: true, dependent: :destroy
  has_many :users, through: :department_users
end
