class User < ActiveRecord::Base

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :recoverable, :rememberable, :trackable, :validatable

  has_many  :supply_lists
  has_many  :organization_members
  has_many  :organizations, through: :organization_members
  has_one   :admin

  def verify_signup_digest?(digest)
    self.signup_digest == digest
  end

  def send_signup_digest
    digest = SecureRandom.urlsafe_base64
    update(signup_digest: digest)
    UserMailer.new_user(self, digest).deliver_now
  end

  scope :search, -> (s) { q = "%#{s}%" ; where('name ILIKE ? OR email ILIKE ? OR phone ILIKE ? OR account_type ILIKE ?', q, q, q, q) }
  scope :current, -> (s) { s == 'Active' ? q = true : q = false ; where(current: q) if s }

end
