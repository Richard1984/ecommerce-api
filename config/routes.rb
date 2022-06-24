Rails.application.routes.draw do
  # devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "users#show"
  scope :api, defaults: { format: :json } do
    devise_for :users, controllers: { sessions: :sessions, :omniauth_callbacks => "users/omniauth_callbacks" },
                       path_names: { 
                        sign_in: :login,
                        registration: :signup,
                     }

    resource :user, only: [:show, :update]
  end
end
