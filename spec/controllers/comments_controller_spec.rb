require 'rails_helper'

describe CommentsController do
  
  describe "#create" do
    describe "with valid params" do
      
      before(:each) do
        @article = Article.new
        allow(@article).to receive(:id).and_return(1)
        allow(@article).to receive(:slug).and_return('foo')
        allow(Article).to receive(:find).and_return(@article)
        @comment = Comment.new
        allow(@article.comments).to receive(:create!).and_return(@comment)
        @params = {"title" => 'test', "key" => "value"}
      end
      
      it "should build a new comment" do
        do_post
      end

      it "should redirect to the new articles page when requesting HTML" do
        do_post
        expect(response).to redirect_to("/#{@article.slug}")
      end
      
      it "sets a flash message" do
        do_post
        expect(flash[:notice]).to be == "comment was successfully saved."
      end

      def do_post format = 'html'
        post 'create', :article_id => @article.id, :comment => @params, :format => format
      end
    end

    describe "with invalid parameters" do
      before(:each) do
        @errors = instance_double(Array, :collect => [], :to_json => 'JSON')
        
        @article = Article.new
        allow(@article).to receive(:id).and_return(1)
        allow(@article).to receive(:slug).and_return('foo')
        allow(Article).to receive(:find).and_return(@article)
        @comment = Comment.new
        allow(@comment).to receive(:id).and_return(nil)
        allow(@article.comments).to receive(:create!).and_raise(ActiveRecord::RecordInvalid.new(@comment))
        @params = {"commenter" => '', "body" => ""}
      end
      
      it "sets a flash message" do
        do_post
        expect(flash[:notice]).to be == "comment was not saved."
      end
      
      def do_post format = 'html'
        post 'create', :article_id => @article.id, :comment => @params, :format => format
      end
    end
  end

end
