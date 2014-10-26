Rails.application.routes.draw do
  resources :articles
  resources :users
  
  get "/:slug", :controller => "home", :action => "slug" 

  get "/auth/login", :controller => "auth", :action => "index"
  post "/auth/login", :controller => "auth", :action => "login"

  root 'home#index'
  
end
