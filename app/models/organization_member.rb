class OrganizationMember < ActiveRecord::Base
  belongs_to :user,         touch: true
  belongs_to :organization, touch: true

  validates :user_id, presence: true
  validates :organization_id, presence: true

  validates_uniqueness_of :user_id, scope: :organization_id
end
