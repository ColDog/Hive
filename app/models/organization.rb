class Organization < ActiveRecord::Base
  has_many :users
  has_many :supply_lists, through: :users


end
