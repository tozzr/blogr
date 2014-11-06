require "rails_helper"

describe Article do
  fixtures :articles

  describe "#most_recent" do
    it "returns default when no article" do
      allow(Article).to receive(:published_latest_first).and_return([])
      mr = Article.most_recent
      expect(mr.title).to be == "no article"
      expect(mr.text).to be == "yet"
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

  describe "#find_by_slug" do
    it "return the article with that slug" do
      expect(Article.find_by_slug("foo-bar")).to be == articles(:one)
    end
  end
  
end
