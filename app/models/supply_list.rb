class SupplyList < ActiveRecord::Base
  belongs_to :user
  belongs_to :supply

  validates :user_id,   presence: true
  validates :supply_id, presence: true

  validates_uniqueness_of :name, scope: :supply_id

  validate :maximum_level

  private
    def maximum_level
      unless SupplyList.where(supply_id: self.supply_id).count >= self.supply.maximum
        errors.add(:base, 'You are at the maximum number of supplies')
      end
    end

end
