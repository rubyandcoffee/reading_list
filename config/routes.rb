Rails.application.routes.draw do
  resources :authors
  namespace :books do
    resources :reading_list, only: [:index]
    get 'reading_list/add_book', to: 'reading_list#add_book'
    post 'reading_list/update_list', to: 'reading_list#update_list'
  end
  get 'books/yearly_goals', to: 'books#yearly_goals'
  get 'books/shopping_list', to: 'books#shopping_list'
  get 'books/unread', to: 'books#unread'
  get 'books/read', to: 'books#read'
  get 'books/dnf', to: 'books#dnf'
  get 'books/generator', to: 'books#generator'

  resources :books
  resources :genres
  resources :series

  root to: 'books#index'
end
