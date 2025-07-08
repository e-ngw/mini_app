CarrierWave.configure do |config|
  if Rails.env.production?
    config.fog_provider = 'fog/aws'
    config.fog_credentials = {
      provider:              'AWS',
      aws_access_key_id:     ENV['AWS_ACCESS_KEY_ID'],
      aws_secret_access_key: ENV['AWS_SECRET_ACCESS_KEY'],
      region:                'ap-northeast-1' # 作成したバケットのリージョンと合わせる
    }
    config.fog_directory  = 'mini-app-image-bucket1' # あなたのバケット名
    config.fog_public     = true
    config.storage        = :fog
  else
    config.storage = :file
  end
end
