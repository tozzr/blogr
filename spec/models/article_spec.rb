require "rails_helper"

describe Article do
  fixtures :articles

  describe "#most_recent" do
    it "returns default when no article" do
      allow(Article).to receive(:published_latest_first).and_return([])
      expect(Article.most_recent).to be == Article.no_articles
    end

    it "returns the last published entry" do
      expect(Article.most_recent).to be == articles(:one)
    end
  end

  describe "#published_latest_first" do
    it "returns only published articles order by updated DESC" do
      articles = []
      articles << articles(:one)
      articles << articles(:two)
      expect(Article.published_latest_first).to be == articles
    end
  end

  describe "#==" do
    it "new articles" do
      expect(Article.new).to be == Article.new
      expect(Article.new).to_not be == Article.new(:title=>'foo', :text=>'bar')
      expect(Article.new(:title=>'foo', :text=>'bar')).to_not be == Article.new
    end

    it "new articles are equal when title and text are equal" do
      expect(Article.new(:title=>'foo', :text=>'bar')).to be == Article.new(:title=>'foo', :text=>'bar')
      expect(Article.new(:title=>'no', :text=>'thing')).to_not be == Article.new(:title=>'foo', :text=>'bar')
    end

  end

end
