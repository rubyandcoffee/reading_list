Rails.application.routes.draw do
  resources :book_goal_timelines
  resources :genres

  resources :authors do
    collection do
      post :import
    end
  end

  resources :books do
    resources :rentals, only: :destroy

    collection do
      post 'import'
      get 'export'
      get 'yearly_goals'
      get 'reviews'
      get 'buy'
      get 'generator'
      get 'todo'
      get 'manage'
    end

    member do
      patch 'update_rating'
      post 'remove_from_shelf'
    end
  end

  resources :series do
    collection do
      post 'import'
    end
  end

  root to: 'books#index'
end
