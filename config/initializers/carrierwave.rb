# CarrierWave.configure do |config|
#   if Rails.env.production?
#     config.fog_provider = "fog/aws"
#     config.fog_credentials = {
#       provider:              "AWS",
#       aws_access_key_id:     ENV["AWS_ACCESS_KEY_ID"],
#       aws_secret_access_key: ENV["AWS_SECRET_ACCESS_KEY"],
#       region:                "ap-northeast-1" # 作成したバケットのリージョンと合わせる
#     }
#     config.fog_directory  = "mini-app-image-bucket1" # あなたのバケット名
#     config.fog_public     = true
#     config.storage        = :fog
#   else
#     config.storage = :file
#   end
# end

require "carrierwave/storage/abstract"
require "carrierwave/storage/file"
require "carrierwave/storage/fog"

CarrierWave.configure do |config|
  if Rails.env.production?
    config.storage :fog
    # config.fog_provider = "fog/aws"
    config.fog_directory  = "mini-app-image-bucket1" # あなたのバケット名
    # 以下の fog_attributes を削除または空にすることで ACL を送らないようにする
    config.fog_attributes = {}  # 👈 これが重要！
    # config.fog_public     = true  # これは問題ない（画像URLを公開にするだけ）
    config.fog_credentials = {
      provider: "AWS",
      aws_access_key_id: Rails.application.credentials.dig(:aws, :access_key_id),
      aws_secret_access_key: Rails.application.credentials.dig(:aws, :secret_access_key),
      region: "ap-northeast-1", # リージョン
      path_style: true
    }
  else
    config.storage = :file
  end
end
