Rails.application.routes.draw do

  resources :strategies
  resources :loans, only: [:index, :show] do
    collection do
      post :search
    end
  end

  devise_for :users, controllers: {}

  devise_scope :user do
    authenticated :user do
      root :to => 'dashboard#index', as: :authenticated_root
    end
    unauthenticated :user do
      root :to => 'home#index', as: :unauthenticated_root
    end
  end

  namespace :admin do
    resources :loans do
      collection do
        get :upload
        post :post_upload
      end
    end

    resources :notes do
      collection do
        get :upload
        post :post_upload
      end
    end
  end

  get 'home/index'
  root to: 'home#index'

  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'
end
