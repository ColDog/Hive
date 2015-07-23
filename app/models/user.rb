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

  def verify_signup_digest?(digest)
    crypt = ActiveSupport::MessageEncryptor.new(Rails.application.secrets.secret_key_base)
    begin
      self.signup_digest == crypt.decrypt_and_verify(digest)
    rescue Exception => e
      false
    end
  end

  def send_signup_digest
    crypt = ActiveSupport::MessageEncryptor.new(Rails.application.secrets.secret_key_base)
    digest = SecureRandom.urlsafe_base64
    update(signup_digest: digest)
    encrypted_data = crypt.encrypt_and_sign(digest)
    UserMailer.new_user(self, encrypted_data).deliver_now
  end

end
