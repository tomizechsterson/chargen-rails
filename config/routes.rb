Rails.application.routes.draw do
  root "characters#index"

  get "signup" => "users#new"

  resources :users
  resources :characters
end
