Rails.application.routes.draw do
  resources :articles do
    resources :comments
  end
  
  resources :users
  
  get "/:slug", :controller => "home", :action => "slug", :as => :slug 

  get "/auth/login", :controller => "auth", :action => "index"
  post "/auth/login", :controller => "auth", :action => "login"
  get "/auth/logout", :controller => "auth", :action => "logout"

  root 'home#index'
  
end
