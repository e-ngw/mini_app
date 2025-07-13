class Follow < ApplicationRecord
  # Userモデルから以下を通して参照される
  belongs_to :follower, class_name: "User"
  belongs_to :followed, class_name: "User"
end
