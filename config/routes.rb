Rails.application.routes.draw do   
  # devise_scope :user do
  #   # Redirests signing out users back to sign-in
  #   get 'users', to: 'devise/sessions#new'
  # end
  devise_for :users
  root 'users#index'
  resources :users, only: [:index, :show] do
    resources :posts, only: [:index, :show, :new, :create]
  end
  resources :comments, only: [:new, :create]
  resources :likes, only: [:create]
end
