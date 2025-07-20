class Post < ApplicationRecord
  validates :image, presence: { message: "を選択してください" }
  validates :title, presence: true, length: { maximum: 35}
  validates :body, length: { maximum: 65_535 }
  validates :restaurant_info, length: { maximum: 255 }
  validates :food_info, length: { maximum: 255 }

  belongs_to :user
  has_many :taggings, dependent: :destroy
  has_many :tags, through: :taggings

  attr_accessor :tag_names

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

  ### 投稿のbodyバリデーション
  FORBIDDEN_WORDS = %w[
  まずい まずっ 不味 マズい マズイ まずすぎる 美味しくない おいしくない 食えない 食べられない もう食べたくない
  最悪 ひどい 酷すぎ 失敗 不快 だめ 期待外れ 残念 がっかり ひどすぎ
  くさい 臭い 変な味 腐ってる くさってる カビてる
]

  validate :body_cannot_include_forbidden_words

  # imageカラムにUploaderをマウントする
  mount_uploader :image, PostImageUploader

  private

  def body_cannot_include_forbidden_words
    return if body.blank?

    FORBIDDEN_WORDS.each do |word|
      if body.include?(word)
        errors.add(:body, ":「#{word}」を含む言葉は使用禁止です")
        break
      end
    end
  end
end
