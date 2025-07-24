class PostsController < ApplicationController
  # before_action :set_post, only: %i[ show edit update destroy ]

  def index
    # @posts = Post.includes(:tags, :user).order(created_at: :desc)
    @q = Post.ransack(params[:q])
    @posts = @q.result(distinct: true).includes(:tags, :user).where(users: { is_public: true }).order(created_at: :desc)
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.build(post_params)
    tag_list = params[:post][:tag_names].split(",") # フォームから送られたタグを,で区切った単語で配列を作っている
    @post.tag_names = tag_list.join(",") # Postインスタンスへ仮想属性tag_namesに値を代入し、バリデーション対象にする処理。
    # save_tagsメソッドだけでは post.tags << add_tag によってタグを紐付けているだけで、バリデーション対象になっていない。

    if @post.save
      @post.save_tags(tag_list) # 上記で定義したtag_list
      redirect_to posts_path, notice: t("defaults.flash_message.created", item: Post.model_name.human)
    else
      @tag_list = params[:post][:tag_names]
      flash.now[:error] = t("defaults.flash_message.not_created", item: Post.model_name.human)
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @post = Post.find(params[:id])
  end

  def edit
    @post = current_user.posts.find(params[:id])
    @tag_list = @post.tags.pluck(:name).join(",")
  end

  def update
    @post = current_user.posts.find(params[:id])
    tag_list = params[:post][:tag_names].split(",") # 入力されたタグを受け取る
    @post.tag_names = tag_list.join(",")

    if @post.update(post_params)
      @post.save_tags(tag_list)
      redirect_to post_path(@post), notice: t("defaults.flash_message.updated", item: Post.model_name.human)
    else
      @tag_list = params[:post][:tag_names]
      flash.now[:error] = t("defaults.flash_message.not_updated", item: Post.model_name.human)
      render :edit, status: :unprocessable_entity
      # status: :unprocessable_entity はHTTPステータスコード 422のこと。
      # フォームバリデーションで失敗したときなどに使われる。入力エラーをユーザーに返すときに適切

    end
  end

  def destroy
    @post = current_user.posts.find(params[:id])
    @post.destroy!
    redirect_to posts_path, notice: t("defaults.flash_message.deleted", item: Post.model_name.human), status: :see_other
    # status: :see_other はHTTPステータスコード303のこと。
    # リダイレクト時に使われる。POSTのあとのGETリクエストに変換して、他のページへ遷移させたいときに便利
  end

  private

  def post_params
    params.require(:post).permit(:image, :title, :image_cache, :body, :restaurant_info, :food_info)
  end
end
