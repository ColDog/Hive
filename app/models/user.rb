class User < ActiveRecord::Base
  has_many  :supply_lists
  has_many  :organization_members
  has_many  :organizations, through: :organization_members
  has_one   :admin

  has_secure_password
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
            format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }
  validates :password, presence: true, length: { minimum: 6 }, allow_nil: true

  def create_signup_digest
    self.signup_digest = SecureRandom.urlsafe_base64
  end

end
