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

      resource :user, only: [:show, :update]
    end
  
  resources :products do
    resources :reviews, only: [:new, :show, :create, :index, :edit, :update]
  end
  resources :categories
end
