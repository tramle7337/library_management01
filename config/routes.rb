Rails.application.routes.draw do
  default_url_options host: "localhost:3000"
  root "books#index"
  get "sessions/new"
  get "users/new"
  get "/help", to: "static_pages#help"
  get "/about", to: "static_pages#about"
  get "/contact", to: "static_pages#contact"
  get "/signup", to: "users#new"
  post "/signup", to: "users#create"
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"
  get "/newcategories", to: "categories#new"
  get "/categories", to: "categories#index"
  get "/newpublishers", to: "publishers#new"
  get "/publishers", to: "publishers#index"
  get "/newauthors", to: "authors#new"
  get "/authors", to: "authors#index"
  get "/newbook", to: "books#new"
  resources :users
  resources :books, :authors, :publishers, :categories
end
