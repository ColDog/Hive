class User < ActiveRecord::Base
  DESK_ID = Supply.find_by(name: 'Desk').id

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :recoverable, :rememberable, :trackable, :validatable

  has_many  :supply_lists, dependent: :destroy
  has_many  :organization_members, dependent: :destroy
  has_many  :organizations, through: :organization_members
  has_one   :admin

  validate :if_current_then_no_date

  def active
    self.current ? '√' : 'X'
  end

  def desk
    if DESK_ID
      desk = self.supply_lists.find { |list| list.supply_id == DESK_ID }
      if desk
        desk.name
      else
        nil
      end
    else
      nil
    end
  end

  def organization_supplies
    ids = self.organizations.pluck(:id)
    SupplyList.where(organization_id: ids)
  end

  def verify_signup_digest?(digest)
    self.signup_digest == digest
  end

  def send_signup_digest
    digest = SecureRandom.urlsafe_base64
    update(signup_digest: digest)
    UserMailer.new_user(self, digest).deliver_now
  end

  scope :search,  -> (s) { q = "%#{s}%" ; where('name ILIKE ? OR email ILIKE ? OR phone ILIKE ? OR account_type ILIKE ?', q, q, q, q) }
  scope :current, -> (s) { s == 'Active' ? q = true : q = false ; where(current: q) if s }

  private
    def if_current_then_no_date
      if current && inactive_on.present?
        errors.add(:base, 'Currently active should not be checked if a date for inactive on is chosen.')
      elsif current == false && inactive_on.present? == false
        errors.add(:base, 'If current is not checked, you should select a date.')
      end
    end

end
