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
  resources :users
  resources :books
  resources :authors
  resources :publishers
  resources :categories
  resources :requests do
    member do
      get "accept_request"
      patch "deny_request"
    end
  end
  resources :request_details, only: [:create, :update, :destroy]
  resource :cart, only: [:show]

  namespace :admin do
    resources :books
    resources :requests
  end
end
