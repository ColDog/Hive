# encoding: utf-8

class AttachmentsUploader < CarrierWave::Uploader::Base

  if Rails.env.production?
    storage :aws
  else
    storage :file
  end

  def store_dir
    'attachments/'
  end

end
