class FollowsController < ApplicationController
  def create
    @user = User.find(params[:followed_id])
    current_user.follow(@user)
    # Turbo Stream形式のテンプレート（app/views/follows/create.turbo_stream.erbを自動的に探す）がある前提ならこれでOK
  end

  def destroy
    # current_userがフォローしている関係active_follows(=Followテーブル）の中から
    # params[:id]（followテーブルの主キー）に一致するものを1件探す
    @follow = current_user.active_follows.find(params[:id])
    # .followed で相手ユーザー（フォローしていた人）の Userインスタンスを取得する。
    # Turbo Streamテンプレートでフォローボタン部分を再描画するため、@user を渡す必要がある。
    @user = @follow.followed
    @follow.destroy
    # これもTurbo Stream用テンプレートがあるならOK
  end
end
