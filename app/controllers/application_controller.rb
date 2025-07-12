class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  # devise利用の機能(ユーザー登録やログイン認証等)を使う前に、configure_permitted_parametersメソッドが実行
  before_action :configure_permitted_parameters, if: :devise_controller?


  # 新規登録後の遷移先指定(deviseのデフォはroot_pathのため)
  def after_sign_up_path_for(resource)
    posts_path
  end

  # ログイン後の遷移先指定(deviseのデフォはroot_pathのため)
  def after_sign_in_path_for(resource)
    posts_path
  end

  # 未ログインでログイン必須ページへアクセスしたときログインページへリダイレクトされる（deviseのヘルパーメソッド）
  before_action :authenticate_user!

  # privateではなく「protected」にすることで他のコントローラーからも参照できる。同じクラス or サブクラスの インスタンス同士 なら呼び出せる
  protected

    # 新規登録時nameもデータ操作許可
    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [ :name ])
    end

  # private

  #   def not_authenticated
  #     redirect_to new_user_session_path, danger: t('defaults.flash_message.require_login')
  #   end
end
