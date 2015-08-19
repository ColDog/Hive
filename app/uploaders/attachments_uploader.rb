# encoding: utf-8

class AttachmentsUploader < CarrierWave::Uploader::Base

  def store_dir
    'attachments/'
  end

end
