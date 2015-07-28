class Supply < ActiveRecord::Base
  has_many :supply_lists

  scope :search, -> (s) { q = "%#{s}%" ; where('name ILIKE ? OR notes ILIKE ?', q, q) }

end
