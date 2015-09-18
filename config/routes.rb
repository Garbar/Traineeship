Rails.application.routes.draw do

  get 'profile', to: 'profile#index', as: 'profile'
  resources :products, only: [:index, :show, :new, :create]
  devise_for :users
  root 'products#index'
end
