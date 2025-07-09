class PostImageUploader < CarrierWave::Uploader::Base
  # Include RMagick or MiniMagick support:
  # include CarrierWave::RMagick
  include CarrierWave::MiniMagick

  # Choose what kind of storage to use for this uploader:
  # 画像の保存場所の設定。ローカルストレージの場合は:file、クラウドストレージの場合は:fogにする
  if Rails.env.production?
    storage :fog
  else
    storage :file
  end
  # storage :fog

  # これを追加！
  def fog_public
    false
  end

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  # 画像を保存するディレクトリを定義。
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  # ファイルがアップロードされていない場合にデフォルトで表示する画像のURLを指定
  # Provide a default URL as a default if there hasn't been a file uploaded:
  def default_url
    "post_placeholder.png"
  end
  # def default_url(*args)
  #   # For Rails 3.1+ asset pipeline compatibility:
  #   # ActionController::Base.helpers.asset_path("fallback/" + [version_name, "default.png"].compact.join('_'))
  #
  #   "/images/fallback/" + [version_name, "default.png"].compact.join('_')
  # end

  # MiniMagickのおかげで様々なサイズやアスペクト比を設定することができる
  # 画像自体をサーバー側で加工・リサイズして保存する処理。処理が行われるタイミングは、画像をアップロードしたとき。
  # 画像の容量も小さくなる。一度だけ変換され、以降はその変換後の画像が使われる。
  # resize_to_fit は指定サイズに収まる最大サイズでアスペクト比（縦横比）を維持したまま縮小する
  # resize_to_fill は、中央をトリミングしながらサイズをピッタリ合わせる処理
  process resize_to_limit: [1280, 1280]

  version :thumb do
    process resize_to_fill: [ 250, 250 ]
  end
  # Process files as they are uploaded:
  # process scale: [200, 300]
  #
  # def scale(width, height)
  #   # do something
  # end

  # 画像を表示箇所によってサイズを変えたい場合があるときはここ
  # Create different versions of your uploaded files:
  # version :thumb do
  #   process resize_to_fit: [50, 50]
  # end

  # 許容する拡張子の設定
  # Add an allowlist of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  def extension_allowlist
    %w[jpg jpeg gif png]
  end

  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  # def filename
  #   "something.jpg"
  # end
end
