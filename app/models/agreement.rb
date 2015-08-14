class Agreement < ActiveRecord::Base
  belongs_to      :organization
  mount_uploader  :agreement, ServiceAgreementUploader
  validates       :agreement, presence: true
  validates       :name,      presence: true
end
