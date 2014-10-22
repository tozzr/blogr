Rails.application.routes.draw do
  resources :articles
  get "/:slug", :controller => "home", :action => "slug" 
  root 'home#index'
  
end
