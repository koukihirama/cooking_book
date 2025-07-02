Rails.application.routes.draw do
  # ホーム画面
  root "home#index"

  resources :families, only: [:new, :create, :show]

  # 家族コードログイン
  resource :family_login, only: [:new, :create]
  delete "/family_logout", to: "family_logins#destroy", as: :family_logout

  # 投稿
  resources :posts

  # レシピ
  resources :recipes

  # ヘルスチェック
  get "up" => "rails/health#show", as: :rails_health_check

  # PWA
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
end