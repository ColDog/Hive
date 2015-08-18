class User < ActiveRecord::Base
  include Validators
  has_many :admins, dependent: :destroy

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :recoverable, :rememberable, :trackable, :validatable

  has_many  :supply_lists,          dependent:  :nullify
  has_many  :supplies,              through:    :supply_lists
  has_many  :organization_members,  dependent:  :destroy
  has_many  :organizations,         through:    :organization_members
  has_one   :admin,                 dependent:  :destroy

  validates_with InactiveOnValidator

  def active
    self.current ? '√' : 'X'
  end

  def desk
    desk = self.supply_lists.find_all { |list| ::DESK_ID.include?(list.supply_id) }
    desk.first.name if desk.first
  end

  def printer
    Supply.find_by(name: 'Printer').supply_lists.where(user_id: self.id).first if Supply.find_by(name: 'Printer')
  end

  def organization_supplies
    ids = self.organizations.pluck(:id)
    SupplyList.where(organization_id: ids)
  end

  def all_supplies
    organization_supplies + supply_lists
  end

  def verify_signup_digest?(digest)
    if self.signup_digest == digest
      self.update(signup_digest: nil)
    else
      false
    end
  end

  def send_mail(content)
    digest = SecureRandom.urlsafe_base64
    update(signup_digest: digest)
    UserMailer.new_user(self, digest, content).deliver_now
  end

  scope :search,  -> (s) { q = "%#{s}%" ; where('name ILIKE ? OR email ILIKE ? OR phone ILIKE ? OR account_type ILIKE ?', q, q, q, q) }
  scope :current, -> (s) { s == 'Active' ? q = true : q = false ; where(current: q) if s }

  def self.import(csv, key)
    self.import_base(
      csv, key: key, password: true, merge: {},
      slice: %w(name email phone account_type inactive_on current password password_confirmation)
    )
  end

end