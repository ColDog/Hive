if Rails.env.production?
  CarrierWave.configure do |config|
    config.storage    = :aws
    config.aws_bucket = ENV['S3_BUCKET']
    config.aws_acl    = 'authenticated-read'

    config.aws_attributes = {
      expires: 1.hour.from_now.httpdate,
      cache_control: 'max-age=3600'
    }

    config.aws_credentials = {
      access_key_id:     ENV['S3_ACCESS_KEY'],
      secret_access_key: ENV['S3_SECRET_KEY']
    }

    config.aws_authenticated_url_expiration = 3600

    @aws_signer = -> (unsigned_url, options) { Aws::CF::Signer.sign_url unsigned_url, options }
  end
else
  CarrierWave.configure do |config|
    config.storage = :file
  end
end
