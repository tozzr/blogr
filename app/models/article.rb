class Article < ActiveRecord::Base

  def self.most_recent
    articles = Article.published_latest_first
    if articles.empty?
      Article.no_articles
    else
      @article = articles[0]
    end
  end

  def self.published_latest_first
    Article.where('published_at IS NOT NULL')
           .order('published_at DESC')
  end

  def self.no_articles
    Article.new(:title => "no article", :text => "yet")
  end

  def self.not_found 
    Article.new(:title => "not found", :text => "")
  end
  
  def ==(other)
    if defined? other.title and defined? other.text
      self.title == other.title and self.text == other.text
    elsif self.title and self.text
      false
    else
      true
    end
  end

end
