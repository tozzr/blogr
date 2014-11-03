require 'rails_helper'

describe AuthController do

  describe "GET 'index'" do
    it "is successful" do
      get :index
      expect(response).to be_success
    end
  end

  describe "POST 'login'" do
    
    it "renders the form when unsuccessfull" do
      post :login, :username => 'wrong', :password => 'wrong'
      expect(response).to render_template('index')    
    end

    it "has no session var when unsuccessfull" do
      post :login, :username => 'wrong', :password => 'wrong'
      expect(session[:userId]).to be_nil    
    end

    it "redirects to articles when successfull" do
      post :login, :username => 'bob', :password => 'pass1234'
      expect(response).to redirect_to(articles_path)    
    end

    it "has session var when successfull" do
      post :login, :username => 'bob', :password => 'pass1234'
      expect(session[:userId]).to eq(1)    
    end

  end

  describe "GET 'logout'" do
    it "destroys the current user session" do
      session[:userId] = 1
      get :logout
      expect(session[:userId]).to be_nil
    end

    it "redirects to the home page" do
      get :logout
      expect(response).to redirect_to(root_path)
    end

    it "sets a flash message" do
      get :logout
      expect(flash[:notice]).to be == "You have been logged out successfully."
    end
  end

end
