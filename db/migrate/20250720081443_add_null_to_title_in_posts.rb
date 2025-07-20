class AddNullToTitleInPosts < ActiveRecord::Migration[7.2]
  def change
    change_column_null :posts, :title, false
  end
end
