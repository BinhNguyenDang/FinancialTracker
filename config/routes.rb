Rails.application.routes.draw do
  resources :user_stocks, only: [:create, :destroy]
  
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations',
  }
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  root'welcome#index'

  get 'my_portfolio', to: 'users#my_portfolio'
  get "following", to: 'users#index'
  get 'search_stock', to: 'stocks#search'
  get 'search_users', to: 'users#search'
  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
