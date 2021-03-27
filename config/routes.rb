Rails.application.routes.draw do
  root "characters#index"

  get "signup" => "users#new"

  resources :users
  resources :characters

  get "signin" => "sessions#new"
  resource :session, only: [:new, :create, :destroy]
end
