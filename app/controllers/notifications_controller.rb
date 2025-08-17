class NotificationsController < ApplicationController
  def index
    @notifications = current_user.notifications.includes(:actor, :notifiable).order(created_at: :desc)
  end
end
