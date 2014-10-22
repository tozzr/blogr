class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :populate_articles
  
  private 

  def populate_articles
    @articles = Article.all.order('created_at DESC')
  end
end
