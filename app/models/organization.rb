class Organization < ActiveRecord::Base
  extend Csv

  attr_accessor :tagging
  has_many :organization_members, dependent: :destroy
  has_many :supply_lists,         dependent: :destroy
  has_many :users, through: :organization_members

  mount_uploader :service_agreement, ServiceAgreementUploader
  mount_uploader :avatar,            AvatarUploader

  validates :name, presence: true, uniqueness: true

  after_save :if_agreement_then_signed
  validate :if_current_then_no_date

  def tagging=(val)
    write_attribute(:tags, val.split(','))
  end

  def description_short
    str = self.description.slice(0,40) ; str += '...' ; str
  end

  def pretty_tags
    str = '' ; tags.each { |t| str += "#{t} "} ; str
  end

  def agreement
    self.signed_service_agreement ? '√' : 'X'
  end

  def active
    self.current ? '√' : 'X'
  end

  def self.import(csv)
    errors = {  }
    successes = []
    count = 0
    CSV.foreach(csv.path, headers: true) do |row|
      hsh = row.to_hash.slice(
        'name', 'description', 'signed_service_agreement', 'current',
        'inactive_on', 'address', 'city', 'province', 'postal'
      )
      begin
        Organization.create! hsh
        successes << hsh['name']
      rescue Exception => e
        if hsh['name']
          errors[ hsh['name'] ] = e.message
        else
          errors[ count ] = e.message
        end
      end
      count += 1
    end
    fin = { } ; fin[:errors] = errors ; fin[:successes] = successes
    return fin
  end



  scope :search, -> (s) { q = "%#{s}%" ; where('name ILIKE ? OR description ILIKE ? OR tags @> ARRAY[?] OR city ILIKE ? OR province ILIKE ? OR postal ILIKE ?', q, q, q, q, q, q) }
  scope :current, -> (s) { s == 'Active' ? q = true : q = false ; where(current: q) if s }

  private
    def if_agreement_then_signed
      if service_agreement.present? && signed_service_agreement == false
        self.update(signed_service_agreement: true)
      elsif service_agreement.present? == false && signed_service_agreement == true
        self.update(signed_service_agreement: false)
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
