Rails.application.routes.draw do
  get 'books/yearly_goals', to: 'books#yearly_goals'
  get 'books/buy', to: 'books#buy'
  get 'books/generator', to: 'books#generator'
  get 'books/export', to: 'books#export'

  namespace :books do
    resources :reading_list, only: [:index]
    get 'reading_list/add_book', to: 'reading_list#add_book'
    post 'reading_list/update_list', to: 'reading_list#update_list'
  end

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
