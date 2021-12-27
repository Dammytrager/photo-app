Rails.application.routes.draw do
  devise_for :users
  root 'welcome#index'

  namespace :user do

    root to: redirect('/user/dashboard')

    namespace :dashboard do
      root to: 'home#index'
      get 'images', to: 'images#index'
      post 'images', to: 'images#create'
      delete 'images', to: 'images#destroy'

      get 'payments', to: 'payments#index'

      get 'accounts', to: 'accounts#index'
      patch 'accounts', to: 'accounts#update'
    end

  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
