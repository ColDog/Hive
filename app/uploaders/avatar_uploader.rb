# encoding: utf-8

class AvatarUploader < CarrierWave::Uploader::Base

  if Rails.env.production?
    storage :fog
  else
    storage :file
  end

  def store_dir
    'avatars/'
  end

  def filename
    @name ||= "AV#{@filename.split('.')[0]}#{timestamp}.#{file.extension}" if original_filename.present?
  end

  def timestamp
    var = :"@#{mounted_as}_timestamp"
    model.instance_variable_get(var) or model.instance_variable_set(var, Time.now.strftime('%C-%m-%dT%H-%M-%S'))
  end


end
