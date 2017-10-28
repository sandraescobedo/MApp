Rails.application.routes.draw do
  devise_for :users

  resources :flights
  resources :users
end
