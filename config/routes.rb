Rails.application.routes.draw do
  resources :products, only: [:index, :show, :new, :create]
  devise_for :users
  root 'products#index'
end
