class FillBlankNamesInUsers < ActiveRecord::Migration[7.2]
  def up
    User.where(name: [nil, ""]).find_each do |user|
      user.update_columns(name: "ユーザー#{user.id}")
    end
  end

  def down
    # 空でOK
  end
end
