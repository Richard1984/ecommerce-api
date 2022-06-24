Rails.application.routes.draw do
  devise_for :users
  # resources :facebook_authentications_controller

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  post '/facebook', to: 'facebook_authentications#create'

  # Defines the root path route ("/")
  # root "articles#index"
end
