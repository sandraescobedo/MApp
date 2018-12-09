Rails.application.routes.draw do
  devise_for :users

  resources :airports
  resources :flights
  resources :users

  root 'flights#index'
end
