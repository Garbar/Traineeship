Rails.application.routes.draw do

  get 'registrations', to: 'registrations#index', as: 'registration'
  post 'registrations/:role', to: 'registrations#create', as: 'registrations'
  get 'profile', to: 'profile#index', as: 'profile'
  resources :products, only: [:index, :show, :new, :create] do
    post 'purchase', on: :member
  end
  devise_for :users
  root 'products#index'
end
