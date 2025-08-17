class Like < ApplicationRecord
  belongs_to :user
  belongs_to :post
  has_many :notification, as: :notifiable, dependent: :destroy

  validates :user_id, uniqueness: { scope: :post_id }

  # Like レコードがDBに保存された直後に create_notification メソッドが自動で実行されるようしている
  after_create :create_notification

  private

  # Notification レコードを作成
  def create_notification
    return if post.user_id == user_id

    Notification.create!(
      recipient: post.user,
      actor: user,
      notifiable: self
    )
  end
end
