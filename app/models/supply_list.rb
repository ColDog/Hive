class SupplyList < ActiveRecord::Base
  belongs_to :user
  belongs_to :supply

  validates :user_id,   presence: true
  validates :supply_id, presence: true

end
