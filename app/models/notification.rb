class Notification < ApplicationRecord
  belongs_to :recipient, class_name: "User"
  belongs_to :actor, class_name: "User"
  belongs_to :notifiable, polymorphic: true

  scope :unread, -> { where(read: false) } # 未読通知を unread で全取得
  default_scope -> { order(created_at: :desc) } # 通知の並べ替えはデフォで降順となるよう指定
end
