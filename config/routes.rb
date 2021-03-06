Rails.application.routes.draw do

  resources :strategies do
    member do
      post :exercise
      post :buy_note
    end
  end

  resources :loans, only: [:index, :show] do
    collection do
      post :search
    end
  end

  resources :user_notes, only: [:index] do
    collection do
      post :import
    end
    member do
      post :sell
    end
  end

  devise_for :users, controllers: {
    :registrations => "users/registrations"
  }

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
        post :download_and_load
      end
    end
  end

  get 'home/index'
  root to: 'home#index'

  #
  # tools and engines
  #
  require 'sidekiq/web'
  require 'sidekiq-scheduler/web'
  authenticate :user, lambda { |user| user.has_role? :admin } do
    mount Sidekiq::Web => '/sidekiq'
  end
end
