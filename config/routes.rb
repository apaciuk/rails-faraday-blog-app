require 'sidekiq/web'

Rails.application.routes.draw do

  get '/privacy', to: 'home#privacy'
  get '/terms', to: 'home#terms'
authenticate :user, lambda { |u| u.admin? } do
  mount Sidekiq::Web => '/sidekiq'

  namespace :madmin do
    resources :services
    namespace :active_storage do
      resources :blobs
    end
    namespace :active_storage do
      resources :attachments
    end
    namespace :active_storage do
      resources :variant_records
    end
    resources :notifications
    resources :announcements
    resources :users
    root to: "dashboard#show"
  end
end

  resources :notifications, only: [:index]
  resources :announcements, only: [:index]
  devise_for :users, controllers: { omniauth_callbacks: "users/omniauth_callbacks" }
  root to: 'home#index'
  scope module: 'users' do
  resources :posts
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
