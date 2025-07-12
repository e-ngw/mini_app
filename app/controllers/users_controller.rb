class UsersController < ApplicationController
  def show
    @user = current_user
    @q = @user.posts.ransack(params[:q])
    @posts = @q.result(distinct: true).includes(:tags).order(created_at: :desc)
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update(user_params)
      redirect_to mypage_path(@user),  notice: t("defaults.flash_message.updated", item: User.model_name.human)
    else
      flash.now[:error] = t("defaults.flash_message.not_updated", item: User.model_name.human)
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :introduction)
  end
end
