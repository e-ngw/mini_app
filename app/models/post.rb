class Post < ApplicationRecord
  validates :image, presence: { message: "：画像の選択は必須です" }
  validates :body, length: { maximum: 65_535 }
  validates :restaurant_info, length: { maximum: 255 }
  validates :food_info, length: { maximum: 255 }

  belongs_to :user

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
