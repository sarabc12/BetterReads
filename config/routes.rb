Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check
  get 'dashboard', to: 'users#dashboard', as: :user_dashboard

  # Defines the root path route ("/")
  # root "posts#index"
  resources :books, only: [:show, :search] do
    resources :reviews, only: [:index, :new, :create]

    resources :posts

    collection do
      get 'search'
    end
    resources :booklists, only: [:create]
  end
  resources :reviews, only: [:destroy]
  resources :posts, only: [:destroy] do
  resources :replies, only: [:show, :create, :destroy]
end

  resources :booklists, only: [:destroy]
  resources :lists
  resources :lists do
    member do
      post 'add_book'
      delete 'remove_book'
       patch 'move_to_read', to: 'lists#move_to_read'
    end
  end
  resources :bookreads, only: [:create, :edit, :update]
end
