Rails.application.routes.draw do

  get 'dashboard/index'

  devise_for :users, controllers: {}

  devise_scope :user do
    authenticated :user do
      root :to => 'dashboard#index', as: :authenticated_root
    end
    unauthenticated :user do
      root :to => 'home#index', as: :unauthenticated_root
    end
  end

  get 'home/index'
  root to: 'home#index'
end
