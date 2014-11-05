class Article < ActiveRecord::Base

  def self.most_recent
    articles = Article.all
    if articles.empty?
      Article.new(:title => 'no article', :text => 'yet')
    else
      @article = articles[-1]
    end
  end

end
