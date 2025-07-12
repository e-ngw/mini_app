class AddIsPublicToUsers < ActiveRecord::Migration[7.2]
  def up
    # 1. 一時的に null を許可してカラムを追加（default は任意）
    add_column :users, :is_public, :boolean, default: true, null: true

    # 2. スキーマ情報を更新して新しいカラムを認識させる
    User.reset_column_information

    # 3. 既存レコードに明示的に true を代入（null を避ける）
    User.update_all(is_public: true)

    # 4. null を禁止に（制約を追加）
    change_column_null :users, :is_public, false
  end

  def down
    # ロールバック時にカラムを削除
    # 安全にロールバックできるよう書いているだけ。migrateが成功すれば実際には処理されないメソッド。
    remove_column :users, :is_public
  end
end
