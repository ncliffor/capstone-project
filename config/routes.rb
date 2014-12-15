Rails.application.routes.draw do
  resource :session, only: [:new, :create, :destroy]
  resources :users, only: [:new, :create, :show, :update, :edit]

  resources :images, only: [:create, :show] do
    resources :image_likes, only: [:create], to: "image_likes", as: "likes"
  end

  resources :searches, only: [:index]

  resources :dive_sites do
    resources :dive_site_likes, only: [:create],
      to: "dive_site_likes", as: "likes"
    resources :comments, only: [:new, :create, :destroy]
  end

  root "dive_sites#index"
end
