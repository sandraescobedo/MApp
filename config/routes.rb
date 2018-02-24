Rails.application.routes.draw do
  get 'flights/index'

  devise_for :users

  resources :airports
  resources :flights
  resources :users

  root 'flights#index'
end
