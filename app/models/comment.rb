class Comment < ApplicationRecord
  validates :body, presence: true, length: { maximum: 65_535 }

  belongs_to :user
  belongs_to :post
  has_many :notification, as: :notifiable, dependent: :destroy

  after_create :create_notification

  private

  def create_notification
    return if post.user_id == user_id

    Notification.create!(
      recipient: post.user,
      actor: user,
      notifiable: self
    )
  end
end
