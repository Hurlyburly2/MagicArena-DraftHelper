Rails.application.routes.draw do
  root 'homes#index'
  # devise_for :users
  
  resources :homes, only: [:index, :create]
  resources :screenshots, only: [:create]
  
  resources :drafts, only: [:index]
  
  namespace :api do
    namespace :v1 do
      resources :screenshots, only: [:index, :create]
    end
  end
end
