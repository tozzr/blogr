require 'rails_helper'

describe ArticlesController do
  fixtures :articles

  describe "GET 'index'" do
    it "is successful" do
      get :index
      expect(response).to be_success
    end

    it "assigns @articles" do
      get :index
      expect(assigns(:articles)).to_not be_nil
    end

    it "renders index template" do
      get :index
      expect(response).to render_template('index')
    end
  end
  
  describe "GET 'show'" do
    before(:each) do
      @article = articles(:one)
    end

    it 'is successful' do
      get :show, :id => @article.id
      expect(response).to be_success
    end

    it "assigns @article" do
      get :show, :id => @article.id
      expect(assigns(:article)).to_not be_nil
    end

    it "renders the 'show' template" do
      get :show, :id => @article.id
      expect(response).to render_template('show')
    end
  end  

  describe "GET 'new'" do
    it 'is successful' do
      get :new
      expect(response).to be_success
    end

    it "assigns @article" do
      get :new
      expect(assigns(:article)).to_not be_nil
    end

    it "renders the 'new' template" do
      get :new
      expect(response).to render_template('new')
    end
  end  

  describe "POST 'create'" do
    before(:each) do
      @article = Article.new
      allow(@article).to receive(:id).and_return(1)
      allow(@article).to receive(:title).and_return('foo')
    end

    context "The save is successful" do
      before(:each) do
        expect(Article).to receive(:new).and_return(@article)
        expect(@article).to receive(:save).and_return(true)
      end

      it "redirects to the 'show' action" do
        post :create, :article => @article.attributes
        expect(response).to redirect_to @article # Put the right show path here
      end

      it "sets a flash message" do
        post :create, :article => @article.attributes
        expect(flash[:notice]).to be == 'Article was successfully created.'
      end
    end

    context "the save fails" do
      before(:each) do
        expect(@article).to receive(:save).and_return(false)
        expect(Article).to receive(:new).and_return(@article)
      end

      it "renders the 'new' action" do
        post :create, :article => @article.attributes
        expect(response).to render_template(:new)
      end

      it "assigns @article" do
        post :create, :article => @article.attributes
        expect(assigns(:article)).to_not be_nil
      end
    end
  end 

  describe "GET 'edit'" do
    before(:each) do
      @article = articles(:one)
    end

    it 'is successful' do
      get :edit, :id => @article.id
      expect(response).to be_success
    end

    it "assigns @article" do
      get :edit, :id => @article.id
      expect(assigns(:article)).to_not be_nil
    end

    it "renders the 'edit' template" do
      get :edit, :id => @article.id
      expect(response).to render_template('edit')
    end
  end  

  describe "PUT 'update'" do
    before(:each) do
      @article = articles(:one)
    end

    context "the update is successful" do
      before(:each) do
        expect(@article).to receive(:update).and_return(true)
        expect(Article).to receive(:find).with(@article.id.to_s).and_return(@article)
      end

      it "redirects to 'show' action" do
        put :update, :id => @article.id, :article => {title: 'some title', text: 'some text'} # Add here some attributes for the model
        expect(response).to redirect_to(article_path(@article)) # Put the right show path here
      end

      it "sets a flash message" do
        put :update, :id => @article.id, :article => {title: 'some title', text: 'some text'} # Add here some attributes for the model
        expect(flash[:notice]).to be == 'Article was successfully updated.' # Your flash message here
      end
    end

    context "the update fails" do
      before(:each) do
        expect(@article).to receive(:update).and_return(false)
        expect(Article).to receive(:find).with(@article.id.to_s).and_return(@article)
      end

      it "renders the 'edit' action" do
        put :update, :id => @article.id, :article => {title: 'some title', text: 'some text'} # Add here some attributes for the model
        expect(response).to render_template(:edit)
      end

      it "assigns @article" do
        put :update, :id => @article.id, :article => {title: 'some title', text: 'some text'} # Add here some attributes for the model
        expect(assigns(:article)).to_not be_nil
      end
    end
  end 

  describe "DELETE 'destroy'" do
    before(:each) do
      @article = articles(:one)
      expect(Article).to receive(:find).with(@article.id.to_s).and_return(@article)
    end

    it "should delete the article" do
      expect(@article).to receive(:destroy).and_return(true)
      delete :destroy, :id => @article.id
    end

    it "should redirect to index page" do
      delete :destroy, :id => @article.id
      expect(response).to redirect_to(:articles)
    end

    it "sets a flash message" do
      delete :destroy, :id => @article.id
      expect(flash[:notice]).to be == 'Article was successfully destroyed.' # Your flash message here
    end
  end

end
