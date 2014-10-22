require 'rails_helper'

describe Article do
  fixtures :articles

  describe "#most_recent" do
    it 'returns the last entry' do
      expect(Article.most_recent).to be == articles(:two)
    end
  end

  describe "#find_by_slug" do
    it "return the article with that slug" do
      expect(Article.find_by_slug('foo-bar')).to be == articles(:one)
    end
  end
  
end
