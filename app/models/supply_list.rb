class SupplyList < ActiveRecord::Base
  belongs_to :user
  belongs_to :supply
  belongs_to :organization

  validates :supply_id, presence: true
  validates :name,      presence: true

  # validates_uniqueness_of


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

  def self.build_csv(scope = :all, args = [])
    CSV.generate do |csv|
      csv << ['id', 'name', 'supply name', 'owner name', 'type']
      self.send(scope, *args).each do |record|
        csv << [record.id, record.name, record.supply.name, record.owner ? record.owner.name : nil, record.type]
      end
    end
  end

  def self.import(csv, supply_id)
    errors = {  }
    successes = []
    count = 0
    CSV.foreach(csv.path, headers: true) do |row|
      hsh = row.to_hash.slice('name', 'notes', 'id').merge('supply_id' => supply_id.to_i)
      Rails.logger.info "ROW OF CSV UPLOAD: #{hsh}"
      begin
        sup = SupplyList.find_by(id: hsh['id'])
        if sup
          sup.update! hsh
        else
          Rails.logger.info "ABOUT TO CREATE: #{hsh}"
          hsh['id'] = nil
          SupplyList.create! hsh
        end
        successes << hsh['name']
      rescue Exception => e
        if hsh['name']
          errors[ hsh['name'] ] = e.message
        else
          errors[ count ] = e.message
        end
      end
      count += 1
    end
    fin = { } ; fin[:errors] = errors ; fin[:successes] = successes
    return fin
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
