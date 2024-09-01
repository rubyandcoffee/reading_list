Rails.application.routes.draw do
  get 'books/yearly_goals', to: 'books#yearly_goals'
  get 'books/buy', to: 'books#buy'
  get 'books/generator', to: 'books#generator'
  get 'books/export', to: 'books#export'
  post 'books/remove_from_shelf/:id', to: 'books#remove_from_shelf'

  resources :genres

  resources :authors do
    collection do
      post :import
    end
  end

  resources :books do
    collection do
      post :import
    end
  end

  resources :series do
    collection do
      post :import
    end
  end

  root to: 'books#index'
end
