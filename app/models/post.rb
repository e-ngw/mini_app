class Post < ApplicationRecord
  validates :body, length: { maximum: 65_535 }
  validates :restaurant_info, length: { maximum: 255 }
  validates :food_info, length: { maximum: 255 }

  belongs_to :user
end
