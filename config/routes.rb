Rails.application.routes.draw do
  # ホームページとルートの設定
  root "home#index"
  get "home/index"

  # ユーザー認証 (Devise)
  devise_for :users, controllers: {
    registrations: "users/registrations"
  }

  # 投稿 (Posts) のリソースフルルーティング
  resources :posts

  # レシピ (Recipes) のリソースフルルーティング
  resources :recipes

  # Rails のヘルスチェック
  get "up" => "rails/health#show", as: :rails_health_check

  # プログレッシブウェブアプリ (PWA) 関連
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
end
