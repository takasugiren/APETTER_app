Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    passwords: 'users/passwords'
  }
  root 'homes#top'
  get "search" => "searches#search"
  # ゲストログイン
  devise_scope :user do
    post '/users/guest_sign_in', to: 'users/sessions#guest_sign_in'
  end
  resources :tweets do
    resources :tweet_comments, only: [:create, :destroy]
    resource :favorites, only: [:create, :destroy]
  end
  resources :tags do
    get 'tweets', to: 'tweets#search'
  end
  resources :users, only: [:show, :edit, :update] do
    resource :relationships, only: [:create, :destroy]
    get 'followings' => 'relationships#followings', as: 'followings'
    get 'followers' => 'relationships#followers', as: 'followers'
  end
  # 通知一覧
  resources :notifications, only: :index
end
