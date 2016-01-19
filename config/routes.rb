Rails.application.routes.draw do

  root 'bestsellers#index'

  resources :books, only: [:index, :show] do
    collection do
      resources :bestsellers, only: [:index, :show]
    end
  end

  resources :authors, only: [:show]
end
