Rails.application.routes.draw do
  get root to: "welcome#index"

  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"

  resources :about, only: :index

  namespace :admin do
    resources :dashboard, only: :index
    resources :about, only: [:index, :edit, :update]
  end
end
