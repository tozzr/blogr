require 'rails_helper'

describe Article do
  fixtures :articles

  describe "#most_recent" do
    it 'returns the last entry' do
      expect(Article.most_recent).to be == articles(:two)
    end
  end
  
end
