class User < ActiveRecord::Base

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many  :supply_lists
  has_many  :organization_members
  has_many  :organizations, through: :organization_members
  has_one   :admin

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

  scope :search, -> (s) { q = "%#{s}%" ; where('name ILIKE ? OR email ILIKE ? OR phone ILIKE ? OR account_type ILIKE ?', q, q, q, q) }
  scope :current, -> (s) { s == 'Active' ? q = true : q = false ; where(current: q) if s }

end
