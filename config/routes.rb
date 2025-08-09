Rails.application.routes.draw do
  root "static_pages#top"

  devise_for :users # deviseを使用するURLに「users」を含むということ

  ### マイページ用
  get "/mypage", to: "users#show", as: "mypage" # resources :users, only: [:show]と同じルーティング
  get "/mypage/edit", to: "users#edit", as: :edit_mypage
  patch "/mypage", to: "users#update"

  ### 他人のプロフィールページ用
  resources :users, only: [ :show ] do
    # UserとFollowは関連づけられているためuserのidが必要。なのでfollowをネストする。
    member do
    get :followings  # /users/:id/followings
    get :followers   # /users/:id/followers
    end
  end

  resources :posts, only: %i[ index new create show edit update destroy ] do
    resources :comments, only: %i[ create destroy ], shallow: true
  end
  resources :follows, only: %i[ create destroy ]

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/*
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  # Defines the root path route ("/")
  # root "posts#index"
end
