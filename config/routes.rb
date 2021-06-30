Rails.application.routes.draw do
  root to: 'top_pages#index'
  namespace :api, {format: 'json'} do
    namespace :v1 do
      resources :users, only: [:index, :show, :create, :update]  do
        member do
          get :profile
        end
      end
      resources :sessions, only: [:create, :destroy]
      resources :hugs, only: [:index, :create, :update, :destroy]
    end
  end
  get '*path', to: 'top_pages#index'
end
