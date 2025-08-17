class Follow < ApplicationRecord
  # Userモデルから以下を通して参照される
  belongs_to :follower, class_name: "User"
  belongs_to :followed, class_name: "User"

  has_many :notification, as: :notifiable, dependent: :destroy

  after_create :create_notification

  private

  # Notification レコードを作成
  def create_notification
    return if follower_id == followed_id # 自分自身をフォローした場合は通知しない

    Notification.create!(
      recipient: followed,
      actor: follower,
      notifiable: self
    )
  end
end
