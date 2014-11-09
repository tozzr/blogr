require "rails_helper"

describe Article do
  fixtures :articles

  describe "#most_recent" do
    it "returns default when no article" do
      allow(Article).to receive(:published_latest_first).and_return([])
      a = Article.most_recent
      expect(a.title).to be == "no article"
      expect(a.text).to be == "yet"
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

  describe "#find_published_by_slug" do
    it "returns nil when the article with that slug is not publishd" do
      a = Article.find_published_by_slug("foo-3")
      expect(a.title).to be == "not found"
      expect(a.text).to be == ""
    end

    it "only returns the article with that slug when it is published" do
      expect(Article.find_published_by_slug("foo-bar")).to be == articles(:one)
    end
  end
  
end
