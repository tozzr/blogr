require 'rails_helper'

describe HomeController do
  fixtures :articles

  describe "GET 'index'" do
    before(:each) do
      @article = articles(:one)
      allow(Article).to receive(:most_recent).and_return(articles(:one))
    end

    it "is successful" do
      get :index
      expect(response).to be_success
    end

    it "assigns @article" do
      get :index
      expect(assigns(:article)).to_not be_nil
    end

    it "assigns @articles" do
      get :index
      expect(assigns(:articles)).to_not be_nil
    end

    it "renders the 'index' template" do
      get :index
      expect(response).to render_template('index')
    end
  end

  describe "GET '/:slug'" do
    before(:each) do
      @article = articles(:one)
      allow(Article).to receive(:find_by_slug).and_return(articles(:one))
    end

    it "is successful" do
      get :slug, :slug => @article.slug
      expect(response).to be_success
    end

    it "assigns @article" do
      get :slug, :slug => @article.slug
      expect(assigns(:article)).to_not be_nil
    end

    it "renders the 'index' template" do
      get :slug, :slug => @article.slug
      expect(response).to render_template('index')
    end

    it "assigns @articles" do
      get :slug, :slug => @article.slug
      expect(assigns(:articles)).to_not be_nil
    end

  end

end
