# encoding: utf-8

class ServiceAgreementUploader < CarrierWave::Uploader::Base

  if Rails.env.production?
    storage :fog
  else
    storage :file
  end

  def store_dir
    'service_agreements/'
  end

  def filename
    @name ||= "SA#{@filename.split('.')[0]}#{timestamp}.#{file.extension}" if original_filename.present?
  end

  def timestamp
    var = :"@#{mounted_as}_timestamp"
    model.instance_variable_get(var) or model.instance_variable_set(var, Time.now.strftime('%C-%m-%dT%H-%M-%S'))
  end


end
