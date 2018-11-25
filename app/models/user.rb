class User < ApplicationRecord
  after_create :create_tenant
  has_many :articles, dependent: :destroy
  before_save { self.email = email.downcase }
  validates :username, presence: true, uniqueness: {case_sensitive: false}, length: {minimum: 3, maximum: 25 }
  validates :subdomain, presence: true, uniqueness: {case_sensitive: false}, length: {minimum: 3, maximum: 25 }
  VALID_EMAIL_REGEX= /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: {maximum: 105}, uniqueness: {case_sensitive: false}, format: { with: VALID_EMAIL_REGEX }
  has_secure_password

  private
    def create_tenant
      Apartment::Tenant.create('subdomain')
    end

end
