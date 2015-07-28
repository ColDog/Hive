class SupplyList < ActiveRecord::Base
  belongs_to :user
  belongs_to :supply

  validates :supply_id, presence: true
  validates :name,      presence: true
  validates_uniqueness_of :name, scope: :supply_id
  validates_uniqueness_of :supply_id, scope: :user_id

  validate :user_xor_organization
  validate :maximum_level

  def owner
    if user?
      self.user
    elsif organization?
      self.organization
    end
  end

  def user?
    self.user_id.present?
  end

  def organization?
    self.organization_id.present?
  end

  private
    def maximum_level
      if SupplyList.where(supply_id: self.supply_id).count >= self.supply.maximum
        errors.add(:base, 'You are at the maximum number of supplies')
      end
    end

    def user_xor_organization
      if user? or organization? and !(user? && organization?)
        errors.add(:base, 'User or an organization must be present.')
      end
    end

end
