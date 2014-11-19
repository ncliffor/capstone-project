Rails.application.routes.draw do
  resource :session, only: [:new, :create, :destroy]
  resources :users, only: [:new, :create, :show, :update, :edit]
  resources :dive_sites, only: [:new, :create, :index, :show]

  resources :images, only: [:create, :show] do
    resources :image_likes, only: [:create], to: "image_likes", as: "likes"
  end


  root "dive_sites#index"
end
