class AddFieldsToPosts < ActiveRecord::Migration[7.2]
  def change
    add_column :posts, :body, :text
    add_column :posts, :restaurant_info, :string
    add_column :posts, :food_info, :string
    add_reference :posts, :user, foreign_key: true
  end
end
