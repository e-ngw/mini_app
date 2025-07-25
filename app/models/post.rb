class Post < ApplicationRecord
  belongs_to :user
  has_many :taggings, dependent: :destroy
  has_many :tags, through: :taggings

  attr_accessor :tag_names

  validates :image, presence: { message: "を選択してください" }
  validates :title, presence: true, length: { maximum: 35 }, forbidden_word: true
  validates :body, length: { maximum: 65_535 }, forbidden_word: true
  validates :tag_names, forbidden_word: true
  validates :restaurant_info, length: { maximum: 255 }
  validates :food_info, length: { maximum: 255 }
  # 画像の拡張子
  validate :image_extension_validation

  # imageカラムにUploaderをマウントする
  mount_uploader :image, PostImageUploader

  ### タグ検索関連
  # Postモデルのカラムで検索許可するもの
  # 関連モデル（Tag）への検索でも、親（Post）側の設定として ransackable_attributes の定義が必須みたい
  # (内部的にPostの id カラムなども参照されるため）
  def self.ransackable_attributes(auth_object = nil)
    [ "id" ]
  end

  # タグ名（関連モデル）の検索も必要な場合、以下にモデル追加し、その追加したモデルファイルへもransackable_attributesで許容するカラム指定する
  def self.ransackable_associations(auth_object = nil)
    [ "tags" ]
  end

  ### tag処理
  def save_tags(input_tags) # input_tags はpostコントローラーのtag_listの中身が入る
    # 現在postにタグ付けされているか？＞ある場合は配列として取得、ない場合は空の配列[]を生成
    return unless input_tags

    current_tags = self.tags.pluck(:name)
    # 現在取得したタグから送られてきたタグを除いてold_tagとする
    old_tags = current_tags - input_tags
    # 送信されてきたタグから現在存在するタグを除いたタグをnew_tagとする
    new_tags = input_tags - current_tags

    # 不要なタグをpostから削除
    old_tags.each do |old_tag|
      self.tags.delete(Tag.find_by(name: old_tag))
    end

    # 新しいタグをpostへ追加
    new_tags.each do |new_tags|
      add_tag = Tag.find_or_create_by(name: new_tags)
      self.tags << add_tag
    end
  end

  private

  def image_extension_validation
    # return unless image.present?

    begin
      # CarrierWaveの検証（拡張子チェック）を起動させる
      image.cache! unless image.cached? # ここで拡張子NGの場合、CarrierWave::IntegrityError が発生
    rescue CarrierWave::IntegrityError => e # CarrierWave::IntegrityErrorをキャッチし、i18nへ記述した文言に変換
      errors.add(:image, :extension_whitelist_error, extension: File.extname(image.file.filename), allowed_types: image.extension_allowlist.join(", "))
    end
  end
end
