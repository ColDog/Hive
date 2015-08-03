class SupplyList < ActiveRecord::Base
  belongs_to :user
  belongs_to :supply
  belongs_to :organization

  validates :supply_id, presence: true
  validates :name,      presence: true

  validates_uniqueness_of :name,      scope: :supply_id
  validate :uniqueness

  validate :user_xor_organization

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
    def user_xor_organization
      unless (user? or organization? and !(user? && organization?)) or !(user? or organization?)
        errors.add(:user, 'or an organization but not both.')
      end
    end

    def uniqueness
      if user?
        if SupplyList.where(user_id: self.user_id).where(supply_id: self.supply_id).exists?
          errors.add(:user, 'already exists with this supply.')
        end
      elsif organization?
        if SupplyList.where(organization_id: self.organization_id).where(supply_id: self.supply_id).exists?
          errors.add(:organization, 'already exists with this supply.')
        end
      end
    end

end
