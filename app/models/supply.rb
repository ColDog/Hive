class Supply < ActiveRecord::Base
  has_many :supply_lists, dependent: :destroy

  validates :name, presence: true, uniqueness: true

  def picks
    supply_lists.where('organization_id IS NULL OR user_id IS NULL').order(:name)
  end

  def in_use
    self.supply_lists.where('organization_id IS NOT NULL OR user_id IS NOT NULL').count
  end

  scope :search, -> (s) { q = "%#{s}%" ; where('name ILIKE ? OR notes ILIKE ?', q, q) }

end
