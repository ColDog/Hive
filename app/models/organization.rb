class Organization < ActiveRecord::Base
  include Tagging::Instance
  extend  Tagging::ClassMethods

  has_many :organization_members, dependent: :destroy
  has_many :supply_lists,         dependent: :destroy
  has_many :users, through: :organization_members
  has_many :agreements

  mount_uploader :avatar,            AvatarUploader

  validates :name, presence: true

  validate :if_current_then_no_date

  def description_short
    self.description.slice(0,10) if description
  end

  def agreement
    self.signed_service_agreement ? '√' : 'X'
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

  private
    def if_current_then_no_date
      if current && inactive_on.present?
        errors.add(:base, 'Currently active should not be checked if a date for inactive on is chosen.')
      elsif current == false && inactive_on.present? == false
        errors.add(:base, 'If current is not checked, you should select a date.')
      end
    end

end
