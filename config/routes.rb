Rails.application.routes.draw do
  resource :session, only: [:new, :create, :destroy]
  resources :users, only: [:new, :create]

  resources :dive_sites, only: [:new, :create, :index, :show] do
    resources :images, only: [:create]
  end

  root "dive_sites#index"
end
