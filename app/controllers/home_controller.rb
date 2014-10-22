class HomeController < ApplicationController
  def index
    @article = Article.most_recent
  end

  def slug
    @article = Article.find_by_slug(params[:slug])
    render "index"
  end
end
