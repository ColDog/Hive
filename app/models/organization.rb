class Organization < ActiveRecord::Base
  include Validators
  include Tagging::Instance
  extend  Tagging::ClassMethods

  has_many :organization_members, dependent: :destroy
  has_many :supply_lists,         dependent: :destroy
  has_many :users, through: :organization_members
  has_many :agreements,           dependent: :destroy

  mount_uploader :avatar, AvatarUploader

  validates :name, presence: true
  validates_with InactiveOnValidator

  def description_short
    self.description.slice(0,10) if description
  end

  def agreement
    self.signed_service_agreement ? '√' : 'X' # todo change this to look at currently valid?
  end

  def active
    self.current ? '√' : 'X'
  end

  scope :search,  -> (s) { q = "%#{s}%" ; where('name ILIKE ? OR description ILIKE ? OR tags @> ARRAY[?] OR city ILIKE ? OR province ILIKE ? OR postal ILIKE ?', q, q, ["#{s}"], q, q, q) }
  scope :current, -> (s) { s == 'Active' ? q = true : q = false ; where(current: q) if s }

  def self.import(csv, key)
    self.import_base(
      csv, key: key, merge: {},
      slice: %w(name description signed_service_agreement current inactive_on address city province postal)
    )
  end

end
