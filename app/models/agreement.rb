class Agreement < ActiveRecord::Base
  belongs_to      :organization
  mount_uploader  :agreement, AgreementUploader
  validates       :agreement,       presence: true
  validates       :organization_id, presence: true
  def filename
    agreement.file.filename
  end
end
