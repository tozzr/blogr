class HomeController < ApplicationController

  def index
    @article = Article.most_recent
    @articles = Article.all.order('created_at DESC')
  end

  def slug
    @article = Article.find_by_slug(params[:slug])
    render "index"
  end

end
