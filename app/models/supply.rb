class Supply < ActiveRecord::Base
  has_many :supply_lists, dependent: :destroy

  validates :name, presence: true, uniqueness: true
  validates :maximum, presence: true

  scope :search, -> (s) { q = "%#{s}%" ; where('name ILIKE ? OR notes ILIKE ?', q, q) }

end
