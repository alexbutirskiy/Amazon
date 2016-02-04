Rails.application.routes.draw do

  devise_for :users, only: [:sessions, :registrations]
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'

  root 'books#show_bestseller', defaults: {id: '1'}

  resources :books, only: [:index, :show] do
    resources :reviews, only: [:new, :create]
  end
  get '/books/bestsellers/:id', to: 'books#show_bestseller', as: :bestseller

  resources :authors, only: [:show]

  resources :users, only: [] do
    resource :customer, only: [:edit, :create]
    patch 'email',       to: 'customers#update_email'
    patch 'password',    to: 'customers#update_password'
  end

  resources :customers, only: [:update] do
    post  'billing_address',  to: 'customers#create_billing_address'
    patch 'billing_address',  to: 'customers#update_billing_address'
    post  'shipping_address', to: 'customers#create_shipping_address'
    patch 'shipping_address', to: 'customers#update_shipping_address'
  end

  resource :cart, only: [:show, :update] do
    resources :order_items, only: [:create, :destroy]
  end
end
