class Organization < ActiveRecord::Base
  extend Csv::Organization
  extend Csv::Build
  include Tagging::Instance
  extend  Tagging::ClassMethods

  has_many :organization_members, dependent: :destroy
  has_many :supply_lists,         dependent: :destroy
  has_many :users, through: :organization_members

  mount_uploader :service_agreement, ServiceAgreementUploader
  mount_uploader :avatar,            AvatarUploader

  validates :name, presence: true

  validate :if_agreement_then_signed
  validate :if_current_then_no_date

  def description_short
    str = self.description.slice(0,40) ; str += '...' ; str
  end

  def agreement
    self.signed_service_agreement ? '√' : 'X'
  end

  def active
    self.current ? '√' : 'X'
  end

  scope :search,  -> (s) { q = "%#{s}%" ; where('name ILIKE ? OR description ILIKE ? OR tags @> ARRAY[?] OR city ILIKE ? OR province ILIKE ? OR postal ILIKE ?', q, q, ["#{s}"], q, q, q) }
  scope :current, -> (s) { s == 'Active' ? q = true : q = false ; where(current: q) if s }

  private
    def if_agreement_then_signed
      if service_agreement.present? && signed_service_agreement == false
        errors.add(:base, 'Service agreement exists, but is checked false.')
      elsif service_agreement.present? == false && signed_service_agreement == true
        errors.add(:base, 'Service agreement does not exists, but is checked true.')
      end
    end

    def if_current_then_no_date
      if current && inactive_on.present?
        errors.add(:base, 'Currently active should not be checked if a date for inactive on is chosen.')
      elsif current == false && inactive_on.present? == false
        errors.add(:base, 'If current is not checked, you should select a date.')
      end
    end

end
