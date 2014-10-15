class HomeController < ApplicationController

  def index
    @article = Article.most_recent
  end

end
