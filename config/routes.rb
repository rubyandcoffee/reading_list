Rails.application.routes.draw do
  namespace :books do
    resources :reading_list, only: [:index]
    get 'reading_list/add_book', to: 'reading_list#add_book'
    post 'reading_list/update_list', to: 'reading_list#update_list'
  end
  resources :books
  resources :authors
  resources :genres

  root 'books/reading_list#index'
end
