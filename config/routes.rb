Rails.application.routes.draw do
  devise_for :users

  default_url_options host: "localhost:3000"
  root "books#index"
  get "/help", to: "static_pages#help"
  get "/about", to: "static_pages#about"
  get "/contact", to: "static_pages#contact"
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

  namespace :admin do
    resources :books
    resources :authors
    resources :categories
    resources :publishers
    resources :users
    resources :requests do
      member do
        get "accept_request"
        patch "deny_request"
      end
    end
  end

  resources :request_details, only: [:create, :update, :destroy]
  resource :cart, only: [:show]

  #routesLike_Comment
  resources :users do
    resources :likes
    resources :create_comment
  end

  get "user_reviews/new"
  get "user_reviews/edit"

  resources :books do
    resource :likes
    resources :comments
    resources :user_reviews
  end
end
