Rails.application.routes.draw do
  root to: 'top_pages#index'
  namespace :api, {format: 'json'} do
    namespace :v1 do
      resources :users, only: [:index, :show, :create, :update]  do
        member do
          get :profile
          get :following
          get :follower
          get :user_microposts
        end
      end
      resources :relationships, only: [:create, :destroy]
      resources :sessions, only: [:create, :destroy]
      resources :microposts, only: [:create, :destroy] do
      end
      resources :hugs, only: [:index, :create, :update, :destroy]
    end
  end
  get '*path', to: 'top_pages#index'
end
