class Attachment < ActiveRecord::Base
  mount_uploader :file, AttachmentsUploader
  def filename
    file.file.filename
  end
end
