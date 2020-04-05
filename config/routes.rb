Rails.application.routes.draw do
  resources :books

  get '/books/sort', to: 'books#sort'
  root 'books#index'
end
