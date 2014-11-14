require 'rails_helper'

describe Comment, :type => :model do
  describe "valid" do
    it "should not be valid when fields empty" do
      comment = Comment.new
      expect(comment).to_not be_valid

      comment = Comment.new(:commenter => '', :body => '')
      expect(comment).to_not be_valid
    end

    it "should not be valid when commenter is empty" do
      comment = Comment.new(:commenter => '', :body => 'foo')
      expect(comment).to_not be_valid
    end

    it "should not be valid when body is empty" do
      comment = Comment.new(:commenter => 'foo', :body => '')
      expect(comment).to_not be_valid
    end
  end
end
