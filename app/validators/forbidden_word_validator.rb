class ForbiddenWordValidator < ActiveModel::EachValidator
  FORBIDDEN_WORDS = %w[
  まずい まずっ 不味 マズい マズイ まずすぎる 美味しくない おいしくない 食えない 食べられない もう食べたくない
  最悪 ひどい 酷すぎ 失敗 不快 だめ 期待外れ 残念 がっかり ひどすぎ
  くさい 臭い 変な味 腐ってる くさってる カビてる
  ]

  def validate_each(record, attribute, value)
    return if value.blank?

    FORBIDDEN_WORDS.each do |word|
      if value.include?(word)
        record.errors.add(attribute, ":「#{word}」を含む言葉は使用禁止です")
        break
      end
    end
  end
end
