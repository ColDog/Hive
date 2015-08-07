# encoding: utf-8

class AttachmentsUploader < CarrierWave::Uploader::Base

  if Rails.env.production?
    storage :fog
  else
    storage :file
  end

  def store_dir
    'attachments/'
  end

  def filename
    @name ||= "AT#{timestamp}M#{model.name}.#{file.extension}" if original_filename.present?
  end

  def timestamp
    var = :"@#{mounted_as}_timestamp"
    model.instance_variable_get(var) or model.instance_variable_set(var, Time.now.strftime('%C-%m-%dT%H%M'))
  end

end
