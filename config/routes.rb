Rails.application.routes.draw do
  root "characters#index"

  resources :users
  resources :characters
end
