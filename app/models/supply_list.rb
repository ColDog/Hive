class SupplyList < ActiveRecord::Base
  belongs_to :user,         touch: true
  belongs_to :supply,       touch: true
  belongs_to :organization, touch: true

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

  def user_xor_organization
    unless (user? or organization? and !(user? && organization?)) or !(user? or organization?)
      errors.add(:user, 'or an organization but not both.')
    end
  end



  # => CSV OPERATIONS
  def self.build_csv(scope = :all, args = [])
    CSV.generate do |csv|
      csv << ['id', 'name', 'notes', 'supply name', 'owner name', 'type']
      self.send(scope, *args).each do |record|
        csv << [record.id, record.name, record.notes, record.supply.name,
                record.owner ? record.owner.name : nil, record.type]
      end
    end
  end
  def self.import(csv, supply_id, key)
    result = {errors: [], successes: { updated: [], new: [] }}
    count = 0
    CSV.foreach(csv.path, headers: true) do |row|
      hsh = row.to_hash.slice('name', 'notes', 'id').merge('supply_id' => supply_id.to_i)
      begin
        sup = SupplyList.find_by(id: hsh['id'])
        if sup
          sup.update! hsh
          result[:successes][:updated] << hsh
        else
          hsh['id'] = nil
          SupplyList.create! hsh
          result[:successes][:new] << hsh
        end
      rescue Exception => e
        result[:errors] << { name: hsh['name'], error: e.message }
      end
      count += 1
    end
    UploadLog.create(log: result, key: key)
  end

end
