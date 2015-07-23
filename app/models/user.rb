class User < ActiveRecord::Base
  has_many  :supply_lists
  has_many  :organization_members
  has_many  :organizations, through: :organization_members
  has_one   :admin

  before_create :create_signup_digest

  has_secure_password
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
            format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }
  validates :password, presence: true, length: { minimum: 6 }, allow_nil: true

  def get_signup_digest
    BCrypt::Password.new(signup_digest)
  end

  private
    def create_signup_digest
      new_hash = BCrypt::Password.create(SecureRandom.urlsafe_base64)
      self.signup_digest = new_hash
    end

end
