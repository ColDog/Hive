class Attachment < ActiveRecord::Base
  mount_uploader :file, AttachmentsUploader
  validates :name, presence: true
end
