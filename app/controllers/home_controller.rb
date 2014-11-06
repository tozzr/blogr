class HomeController < ApplicationController
  before_filter :populate_navi_items

  def index
    @article = Article.most_recent
  end

  def slug
    @article = Article.find_by_slug(params[:slug])
    render "index"
  end

  private 

  def populate_navi_items
    @navi_items = Article.published_latest_first
  end
end
