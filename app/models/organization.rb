class Organization < ActiveRecord::Base
  attr_accessor :tagging
  has_many :organization_members, dependent: :destroy
  has_many :supply_lists,         dependent: :destroy
  has_many :users, through: :organization_members

  mount_uploader :service_agreement, ServiceAgreementUploader
  mount_uploader :avatar,            AvatarUploader

  validate :if_agreement_then_signed

  def tagging=(val)
    write_attribute(:tags, val.split(','))
  end

  def description_short
    str = self.description.slice(0,40) ; str += '...' ; str
  end

  def pretty_tags
    str = '' ; tags.each { |t| str += "#{t} "} ; str
  end

  scope :search, -> (s) { q = "%#{s}%" ; where('name ILIKE ? OR description ILIKE ? OR tags @> ARRAY[?] OR city ILIKE ? OR province ILIKE ? OR postal ILIKE ?', q, q, q, q, q, q) }
  scope :current, -> (s) { s == 'Active' ? q = true : q = false ; where(current: q) if s }

  private
    def if_agreement_then_signed
      if service_agreement.present? && signed_service_agreement == false
        errors.add(:service_agreement, ' is uploaded but it is checked false')
      elsif service_agreement.present? == false && signed_service_agreement == true
        errors.add(:service_agreement, ' is not uploaded but it is checked true')
      end
    end

end
