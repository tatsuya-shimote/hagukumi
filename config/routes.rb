Rails.application.routes.draw do
  root to: 'top_pages#index'
  namespace :api, {format: 'json'} do
    namespace :v1 do
      resources :users, only: [:show, :create] 
      resources :sessions, only: [:create, :destroy]
      resources :hugs, only: [:index, :create]
    end
  end
  get '*path', to: 'top_pages#index'
end
