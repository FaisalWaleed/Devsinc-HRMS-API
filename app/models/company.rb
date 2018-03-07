class Company < ApplicationRecord
  has_many :users
  has_many :user_roles

  has_many :company_departments, autosave: true, dependent: :destroy
  has_many :departments, through: :company_departments
  accepts_nested_attributes_for :company_departments, allow_destroy: true

  validates :custom_domain, allow_blank: true, uniqueness: true, format: {
    with: /\A(?:[a-z0-9](?:[a-z0-9-]{0,61}[a-z0-9])?\.)+[a-z0-9][a-z0-9-]{0,61}[a-z0-9]\z/,
    message: 'is invalid, use host only like todo.yourcompany.com'
  }
  validates :name, presence: true
  validates :subdomain, uniqueness: true, presence: true, format: {
    with: /\A[a-z0-9](?:[a-z0-9-]{0,61}[a-z0-9])?\z/
  }

  def host
    custom_domain || "#{subdomain}.#{ENV.fetch('default_host')}"
  end
end
