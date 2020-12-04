Rails.application.routes.draw do
  get 'users/index'
  get 'users/show'
  root "soliloquies#top"
  devise_for :users, controllers: {
    registrations: 'users/registrations',
  }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :users do
    collection do

      patch :out
    end


    member do
      get :following, :followers
      get :quit
    end
  end



  devise_scope :user do
    post 'users/guest_sign_in', to: 'users/sessions#new_guest'
  end

  resources :messages, :only => [:create]

  resources :rooms, :only => [:create, :show, :index]

  resources :relationships, only: [:create, :destroy]

  resources :soliloquies do
    resource :favorites, only: [:create, :destroy]
    resources :post_comments, only: [:create, :destroy]
  end

  get "about" => "soliloquies#about"

  get "first" => "users#first"
end
