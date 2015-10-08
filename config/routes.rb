Rails.application.routes.draw do

  scope controller: :registrations do
    get 'registrations'  => :index, as: 'registration'
    get 'registrations/user'  => :user, as: 'registration_user'
    get 'registrations/customer'  => :customer, as: 'registration_customer'
    get 'registrations/admin'  => :admin, as: 'registration_admin'
    post 'registrations/user'  => :create_user, as: 'registrations_user'
    post 'registrations/customer'  => :create_customer, as: 'registrations_customer'
    post 'registrations/admin'  => :create_admin, as: 'registrations_admin'
  end
  get 'profile', to: 'profile#index', as: 'profile'
  resources :products, only: [:index, :show, :new, :create] do
    post 'purchase', on: :member
  end
  devise_for :users
  root 'products#index'
end
