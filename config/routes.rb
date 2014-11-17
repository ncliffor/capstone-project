Rails.application.routes.draw do
  resource :session, only: [:new, :create, :destroy]
  resources :users, only: [:new, :create]
  resources :dive_sites, only: [:index]

  root "dive_sites#index"
end
