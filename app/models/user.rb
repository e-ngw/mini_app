class User < ApplicationRecord
  validates :introduction, length: { maximum: 200 }
  validates :name, presence: true, length: { maximum: 30 }

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :like_posts, through: :likes, source: :post
  has_many :bookmarks, dependent: :destroy
  has_many :bookmark_posts, through: :bookmarks, source: :post


  ### follower_id= フォローしている人、followed_id= フォローされている人 ###
  ### フォローしている関連付け
  # active_followsという名でFollowモデルを関連付け、follower_idを参照する
  # Userモデルから見て「自分がフォローしている Followレコード」を取る（follower_id = 自分）
  has_many :active_follows, class_name: "Follow", foreign_key: "follower_id", dependent: :destroy
  # active_follows = Followモデル（に定義されている 「belongs_to :followed）を通してUserを参照し、
  # 最終的に Userモデルのインスタンス（フォローしている人）を取得
  # active_follows =followsテーブルの中にある各レコードの followed_id から User（フォローしている相手）を取得
  has_many :followings, through: :active_follows, source: :followed

  ### フォローされている関連付け
  has_many :passive_follows, class_name: "Follow", foreign_key: "followed_id", dependent: :destroy
  has_many :followers, through: :passive_follows, source: :follower

  # フォローする
  def follow(user)
    active_follows.create(followed_id: user.id)
    # active_follows.create(...) の時点で、active_follows は self（＝現在のUserインスタンス）をベースにした関連。
    # つまり Rails は「follower_id は self.id（current_user.id）だな」とRailsが自動で補完してくれる
    # followings << user と同義
  end

  # フォローを解除
  def unfollow(other_user)
    active_follows.find_by(followed_id: other_user.id)&.destroy
    # followings.delete(user)と同義
  end

  # フォロー中か判定（フォロー中ならtrueを返す）
  def following?(other_user)
    followings.include?(other_user)
  end


  def own?(object)
    id == object&.user_id
  end


  ## likeに関するインスタンスメソッド
  def like(post)
    like_posts << post
  end

  def unlike(post)
    like_posts.destroy(post)
  end

  def like?(post)
    like_posts.include?(post)
  end


  ## bookmarkに関するインスタンスメソッド
  def bookmark(post)
    bookmark_posts << post
  end

  def unbookmark(post)
    bookmark_posts.destroy(post)
  end

  def bookmark?(post)
    bookmark_posts.include?(post)
  end
end
