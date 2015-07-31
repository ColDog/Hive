class SupplyList < ActiveRecord::Base
  belongs_to :user
  belongs_to :supply
  belongs_to :organization

  validates :supply_id, presence: true
  validates :name,      presence: true
  
  validates_uniqueness_of :name,      scope: :supply_id
  validates_uniqueness_of :supply_id, scope: [:organization_id, :user_id],
                          allow_nil: true, allow_blank: true,
                          message: 'is already selected for this user or organization.'

  validate :user_xor_organization,  if: :no_errors?
  validate :maximum_level,          if: :no_errors?

  def user?
    user_id.present?
  end

  def organization?
    organization_id.present?
  end

  def owner
    if user?
      self.user
    elsif organization?
      self.organization
    end
  end

  def type
    if user?
      'User'
    elsif organization?
      'Organization'
    end
  end

  scope :search, -> (s) do
    if s.present?
      q = "%#{s}%"
      includes(:user, :supply, :organization)
        .references(:user, :supply, :organization)
        .where('supply_lists.name ILIKE ? OR users.name ILIKE ? OR organizations.name ILIKE ?', q, q, q)
    else
      all
    end
  end

  scope :category, -> (type) do
    if type == 'User'
      where('user_id IS NOT NULL')
    elsif type == 'Organization'
      where('organization_id IS NOT NULL')
    else
      all
    end
  end

  private
    def maximum_level
      if SupplyList.where(supply_id: self.supply_id).count >= self.supply.maximum
        errors.add(:base, 'You are at the maximum number of supplies')
      end
    end

    def user_xor_organization
      unless user? or organization? and !(user? && organization?)
        errors.add(:base, 'User or an organization must be present.')
      end
    end

    def no_errors?
      errors.empty?
    end

end
