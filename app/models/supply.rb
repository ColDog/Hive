class Supply < ActiveRecord::Base
  has_many :supply_lists
  accepts_nested_attributes_for :supply_lists
end
