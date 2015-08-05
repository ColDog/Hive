class SupplyList < ActiveRecord::Base
  extend Csv::SupplyList

  belongs_to :user
  belongs_to :supply, touch: true
  belongs_to :organization

  validates :supply_id, presence: true
  validates :name,      presence: true

  validates_uniqueness_of :name,            scope: :supply_id
  validates_uniqueness_of :user_id,         scope: :supply_id, allow_nil: true, allow_blank: true,
                          message: 'already owns this supply.'
  validates_uniqueness_of :organization_id, scope: :supply_id, allow_nil: true, allow_blank: true,
                          message: 'already owns this supply.'


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
    else
      'None'
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
    elsif type == 'Unused'
      where('organization_id IS NULL AND user_id IS NULL')
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

end
