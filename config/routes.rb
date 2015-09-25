Rails.application.routes.draw do

  scope controller: :registrations do
    get 'registrations'  => :index, as: 'registration'
    get 'registrations/user'  => :user, as: 'registration_user'
    get 'registrations/customer'  => :customer, as: 'registration_customer'
    get 'registrations/admin'  => :admin, as: 'registration_admin'
    post 'registrations/:role'  => :create, as: 'registrations'
  end
  get 'profile', to: 'profile#index', as: 'profile'
  resources :products, only: [:index, :show, :new, :create] do
    post 'purchase', on: :member
  end
  devise_for :users
  root 'products#index'
end
