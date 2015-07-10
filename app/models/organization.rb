class Organization < ActiveRecord::Base
  has_many :organization_members
  has_many :supply_lists, through: :users
end
