Rails.application.routes.draw do   
  # devise_scope :user do
  #   # Redirests signing out users back to sign-in
  #   get 'users', to: 'devise/sessions#new'
  # end
  devise_for :users
  root 'users#index'
  resources :users, only: %i[:index :show] do
    resources :posts, only: %i[:index :show :new :create]
  end
  resources :comments, only: %i[:new :create]
  resources :likes, only: [:create]
end
