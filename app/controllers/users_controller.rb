class UsersController < ApplicationController
  def show
    @user = current_user
    @q = @user.posts.ransack(params[:q])
    @posts = @q.result(distinct: true).includes(:tags).order(created_at: :desc)
  end
end
