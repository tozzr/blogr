class Article < ActiveRecord::Base

  def self.most_recent
    @article = Article.all[-1]
  end

end
