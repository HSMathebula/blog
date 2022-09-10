Rails.application.routes.draw do
  root 'users#index'
  resources :users, only: [:index, :show] do
    resources :posts, only: [:index, :show]
  end
  get "/posts/new", to: "posts#new"
  post "posts/new", to: "posts#create"
  get '/comments/new', to: "comments#new"
  post '/comments/new', to: "comments#create"
end
