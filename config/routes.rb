Rails.application.routes.draw do
  # devise_for :users
  # resources :facebook_authentications_controller

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  root "products#index"

  post '/facebook', to: 'facebook_authentications#create'

  # Defines the root path route ("/")
  # root "articles#index"

    scope defaults: { format: :json } do
      devise_for :users, 
      controllers: {
        sessions: 'users/sessions',
        registrations: 'users/registrations'
      },
      path_names: { 
        sign_in: :login,
        registration: :signup
      }
    end

  resources :reviews, only: [:show, :create, :update]
  
  resources :products do
    resources :reviews, only: [:show, :create, :index, :update] do
      resource :vote, except: :index
    end
    post "images", to: "products#update_images"
    delete "images", to: "products#destroy_images"
  end
  resources :categories do
    resources :products, only: [:index]
  end

  resource :account, only: [:show, :update, :destroy] do
    get "avatar", to: "accounts#get_avatar"
    post "avatar", to: "accounts#update_avatar"
    delete "avatar", to: "accounts#destroy_avatar"
    resources :orders, only: [:show, :create, :index] do
      put "update_shipping", to: "orders#update_shipping"
    end
    resources :lists
    resource :cart, only: [ :update, :show, :create, :destroy]
  end

  resource :shop, only: [:show, :update]

  resource :payment, only: [:show, :update] do
    post "success/client", to: "payments#success_client"
    post "success/webhook", to: "payments#success_webhook"
  end
end
