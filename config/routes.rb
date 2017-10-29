Rails.application.routes.draw do
  get 'flights/index'

  devise_for :users

  resources :flights
  resources :users
end
