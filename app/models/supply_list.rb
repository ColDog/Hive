class SupplyList < ActiveRecord::Base
  belongs_to :user
  belongs_to :supply

  validates :user_id,   presence: true
  validates :supply_id, presence: true

  validate  :name_is_unique

  private
    def name_is_unique
      unless SupplyList.where(supply_id: self.supply_id).where(name: self.name).exists?
        errors.add(:name, 'is not unique.')
      end
    end

end
