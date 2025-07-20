class AddTitleToPosts < ActiveRecord::Migration[7.2]
  def up
    # nullable でまずカラムを追加
    add_column :posts, :title, :string

    # モデルのカラム情報を更新してから、仮タイトルを埋める
    Post.reset_column_information
    Post.find_each.with_index(1) do |post, index|
      post.update_column(:title, "仮タイトル#{index}")
    end
  end

  def down
    remove_column :posts, :title
  end
end
