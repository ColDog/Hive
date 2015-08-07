class Attachment < ActiveRecord::Base
  mount_uploader :file, AttachmentsUploader
end
