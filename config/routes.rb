Rails.application.routes.draw do
  get 'rentals/destroy'
  get 'books/yearly_goals', to: 'books#yearly_goals'
  get 'books/reviews', to: 'books#reviews'
  get 'books/buy', to: 'books#buy'
  get 'books/generator', to: 'books#generator'
  get 'books/export', to: 'books#export'
  get 'books/unrated', to: 'books#unrated'

  resources :genres

  resources :authors do
    collection do
      post :import
    end
  end

  resources :books do
    resources :rentals, only: :destroy
    collection do
      post :import
    end
    member do
      patch 'update_rating'
      post 'remove_from_shelf/:id', to: 'books#remove_from_shelf', as: 'remove_from_shelf'
    end
  end

  resources :series do
    collection do
      post :import
    end
  end

  root to: 'books#index'
end
