module NotificationsHelper
  # 通知ごとのテキスト表示
  def notification_text(notification)
    case notification.notifiable_type
    when "Like" then "が投稿にいいねしました"
    when "Comment" then "が投稿にコメントしました"
    when "Follow" then "があなたをフォローしました"
    end
  end

  # 通知ごとのリンク先
  def notification_link(notification)
    case notification.notifiable_type
    when "Like" then post_path(notification.notifiable.post)
    when "Comment" then post_path(notification.notifiable.post, anchor: "comment-#{notification.notifiable.id}")
    when "Follow" then user_path(notification.actor)
    end
  end

  # 未読かどうかの判定（太字CSS）
  def notification_unread_class(notification)
    notification.read ? "" : "fw-bold"
  end
end
