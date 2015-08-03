class Supply < ActiveRecord::Base
  has_many :supply_lists, dependent: :destroy
  accepts_nested_attributes_for :supply_lists, allow_destroy: true

  validates :name, presence: true, uniqueness: true

  def in_use
    self.supply_lists.where('organization_id IS NOT NULL OR user_id IS NOT NULL').count
  end

  scope :search, -> (s) { q = "%#{s}%" ; where('name ILIKE ? OR notes ILIKE ?', q, q) }

end
