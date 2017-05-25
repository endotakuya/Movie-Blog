CarrierWave.configure do |config|
  config.fog_credentials = {
    provider: 'AWS',
    aws_access_key_id: ENV["AWS_ACCESS_KYE_ID"],
    aws_secret_access_key: ENV["AWS_SECRET_ACCESS_KEY"],
    region: ENV['AWS_REGION']
  }

  config.fog_public     = true
  case Rails.env
  when 'production'
    config.fog_directory  = ENV['AWS_S3_BUCKET']
  when 'development', 'test'
    config.fog_directory  = ENV['AWS_S3_BUCKET_DEVELOPMENT']
  end
  config.cache_storage = :fog
end
