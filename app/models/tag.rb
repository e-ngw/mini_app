class Tag < ApplicationRecord
  has_many :taggings, dependent: :destroy, foreign_key: "tag_id"
  has_many :posts, through: :taggings

  validates :name, uniqueness: true

  def self.ransackable_attributes(auth_object = nil)
    [ "name" ]
  end
end
