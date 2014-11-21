require 'rails_helper'

describe CommentsController do
  
  before(:each) do
    @article = Article.new
    allow(@article).to receive(:id).and_return(1)
    allow(@article).to receive(:slug).and_return('foo')
    allow(Article).to receive(:find).and_return(@article)
    @comment = Comment.new
    @params = {"title" => 'test', "key" => "value"}
  end

  describe "CRUD POST create" do
    describe "with valid params" do
      
      before(:each) do
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

  describe "CRUD GET index" do
  
    it "should render the correct template when requesting HTML" do
      do_get
      expect(response).to render_template(:index)
    end

    it "should find the @comments" do
      allow(@article).to receive(:comments).and_return([])
      do_get
    end

    def do_get
      get :index, :article_id => 1
    end

  end

  describe "CRUD DELETE destroy" do
    describe "with a valid id" do
    
      before(:each) do
        allow(Comment).to receive(:find).and_return(@comment)
        allow(@comment).to receive(:id).and_return(1)
      end
      
      it "should find the correct #{@model_name}" do
        allow(Comment).to receive(:find).with(@comment.id.to_s).and_return(@comment)
        do_delete
      end
      
      it "should destroy the comment" do
        allow(@comment).to receive(:destroy).and_return(true)    
        do_delete
      end
      
      it "should redirect to article comments index when requesting HTML" do
        do_delete
        expect(response).to redirect_to("/articles/#{@article.id.to_s}/comments")
      end

      it "sets a flash message" do
        do_delete
        expect(flash[:notice]).to be == "Comment was successfully destroyed."
      end

      it "should render 200 when requesting JSON" do
        do_delete 'json'
        expect(response.status).to be == 204
      end
      
      def do_delete format = 'html'
        delete 'destroy', :article_id => @article.id, :id => @comment.id, :format => format
      end
    end

    describe "with an invalid ID" do
      
      before(:each) do
        allow(Comment).to receive(:find).and_raise(ActiveRecord::RecordNotFound)
      end
      
      it "should redirect to articles comments index when requesting HTML" do
        do_delete
        expect(response).to redirect_to("/articles/#{@article.id.to_s}/comments")    
      end
      
      it "should render a 404 when requesting JSON" do
        do_delete 'json'
        expect(response.status).to be == 404
      end

      def do_delete format = 'html'
        delete 'destroy', :article_id => @article.id, :id => -1, :format => format
      end
    end
  end

  describe "CRUD GET show" do

    describe "with a valid ID" do
      before(:each) do
        allow(Comment).to receive(:find).and_return(@comment)
        allow(@comment).to receive(:id).and_return(1)
      end
      
      it "should find the correct comment" do
        allow(Comment).to receive(:find).with(@comment.id.to_s).and_return(@comment)
        do_get
      end
      
      it "should render the correct template when requesting HTML" do
        do_get
        expect(response).to render_template(:show)
      end
      
      def do_get format = 'html'
        get 'show', :article_id => @article.id, :id => @comment.id, :format => format
      end
    end
    
    describe "with an invalid ID" do
      before(:each) do
        allow(Comment).to receive(:find).and_raise(ActiveRecord::RecordNotFound)
      end
      
      it "should redirect to article comments if not found via HTML" do
        do_get
        expect(response).to redirect_to("/articles/#{@article.id.to_s}/comments")
      end
      
      def do_get format = 'html'
        get 'show', :article_id => @article.id, :id => -1, :format => format
      end
    end

  end

end
