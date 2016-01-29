Rails.application.routes.draw do

  devise_for :users, only: [:sessions, :registrations]
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'

  root 'books#show_bestseller', defaults: {id: '1'}

  resources :books, only: [:index, :show]
  get '/books/bestsellers/:id', to: 'books#show_bestseller', as: :bestseller

  resources :authors, only: [:show]

  # get '/users/:user_id/customer/edit', to: 'customer#edit', as: :edit_customer
  # post '/users/:user_id/customer/update', to: 'customer#update', as: :update_customer
  
  resources :users do
    resource :customer, only: [:edit, :create]
  end

  resources :customers, only: [:update] do
    post  'billing_address',  to: 'customers#create_address'
    patch 'billing_address',  to: 'customers#update_address'
    post  'shipping_address', to: 'customers#create_address'
    patch 'shipping_address', to: 'customers#update_address'
  end
end
