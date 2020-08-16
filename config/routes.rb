Rails.application.routes.draw do
  get root to: "welcome#index"

  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"

  namespace :admin do
    resources :dashboard, only: :index
  end
end
