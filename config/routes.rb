Rails.application.routes.draw do
  resources :users, only: [:create, :update, :destroy]
  resources :goals, only: [:index, :show, :create, :update, :destroy]
  resource :sessions, only: [:create, :destroy]
  get "/current_user", to: "sessions#current"
  # match "*unmatched_route", to:"application#not_found", via: :all
end
