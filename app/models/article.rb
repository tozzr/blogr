class Article < ActiveRecord::Base

  def self.most_recent
    articles = Article.published_latest_first
    if articles.empty?
      Article.new(:title => 'no article', :text => 'yet')
    else
      @article = articles[0]
    end
  end

  def self.published_latest_first
    Article.where(:published => true).order('updated_at DESC')
  end

  def self.find_published_by_slug(slug)
    a = Article.find_by_slug(slug)
    if a.published
      a
    end
  end
end
