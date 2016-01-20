Rails.application.routes.draw do

  root 'bestsellers#index'

  resources :books, only: [:index, :show] do
  end

  get '/books/bestsellers/:id', to: 'books#show_bestseller', as: :bestseller

  resources :authors, only: [:show]
end
