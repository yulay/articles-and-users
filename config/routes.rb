Rails.application.routes.draw do  
  resources :comments, except: %i[index new show]
  resources :categories
  resources :profiles

  get '/confirm_email/:token', to: 'users#confirm_email'

  delete '/logout', to: "sessions#destroy", as: 'logout'

  post '/login', to: "sessions#create", as: 'new_user_session'
  get '/login', to: "sessions#login", as: 'login'

  delete "/user/:id", to: "users#destroy", as: "user_destroy"
  patch "/user/:id", to: "users#update"
  get "/user/:id/edit", to: "users#edit", as: "edit_user"
  get "/user/:id", to: "users#show", as: "user"
  get '/users', to: "users#index"
  post "/users", to: "users#create"
  get "/signup", to: "users#new", as: "signup"

  delete "/article/:id", to: "articles#destroy", as: "article_destroy"
  patch "/article/:id", to: "articles#update"
  post "/articles", to: "articles#create"
  get "/articles", to: "articles#index"
  get "/articles/new", to: "articles#new"
  get "/article/:id", to: "articles#show", as: "article"
  get "/article/:id/edit", to: "articles#edit", as: "article_edit"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root "pages#index"
end
