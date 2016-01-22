Rails.application.routes.draw do

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'

  root 'books#show_bestseller', defaults: {id: '1'}

  resources :books, only: [:index, :show]
  get '/books/bestsellers/:id', to: 'books#show_bestseller', as: :bestseller

  resources :authors, only: [:show]
end
