require 'rails_helper'

describe UsersController do
  fixtures :users

  describe "GET 'index'" do
    it "is successful" do
      get :index
      expect(response).to be_success
    end

    it "assigns @users" do
      get :index
      expect(assigns(:users)).to_not be_nil
    end

    it "renders index template" do
      get :index
      expect(response).to render_template('index')
    end
  end
  
  describe "GET 'show'" do
    before(:each) do
      @user = users(:bob)
    end

    it 'is successful' do
      get :show, :id => @user.id
      expect(response).to be_success
    end

    it "assigns @user" do
      get :show, :id => @user.id
      expect(assigns(:user)).to_not be_nil
    end

    it "renders the 'show' template" do
      get :show, :id => @user.id
      expect(response).to render_template('show')
    end
  end  

  describe "GET 'new'" do
    it 'is successful' do
      get :new
      expect(response).to be_success
    end

    it "assigns @user" do
      get :new
      expect(assigns(:user)).to_not be_nil
    end

    it "renders the 'new' template" do
      get :new
      expect(response).to render_template('new')
    end
  end  

  describe "POST 'create'" do
    before(:each) do
      @user = User.new
      allow(@user).to receive(:id).and_return(1)
      allow(@user).to receive(:username).and_return('bob')
    end

    context "The save is successful" do
      before(:each) do
        expect(User).to receive(:new).and_return(@user)
        expect(@user).to receive(:save).and_return(true)
      end

      it "redirects to the 'show' action" do
        post :create, :user => @user.attributes
        expect(response).to redirect_to @user # Put the right show path here
      end

      it "sets a flash message" do
        post :create, :user => @user.attributes
        expect(flash[:notice]).to be == 'User was successfully created.'
      end
    end

    context "the save fails" do
      before(:each) do
        expect(@user).to receive(:save).and_return(false)
        expect(User).to receive(:new).and_return(@user)
      end

      it "renders the 'new' action" do
        post :create, :user => @user.attributes
        expect(response).to render_template(:new)
      end

      it "assigns @user" do
        post :create, :user => @user.attributes
        expect(assigns(:user)).to_not be_nil
      end
    end
  end 

  describe "GET 'edit'" do
    before(:each) do
      @user = users(:bob)
    end

    it 'is successful' do
      get :edit, :id => @user.id
      expect(response).to be_success
    end

    it "assigns @user" do
      get :edit, :id => @user.id
      expect(assigns(:user)).to_not be_nil
    end

    it "renders the 'edit' template" do
      get :edit, :id => @user.id
      expect(response).to render_template('edit')
    end
  end  

  describe "PUT 'update'" do
    before(:each) do
      @user = users(:bob)
    end

    context "the update is successful" do
      before(:each) do
        expect(@user).to receive(:update).and_return(true)
        expect(User).to receive(:find).with(@user.id.to_s).and_return(@user)
      end

      it "redirects to 'show' action" do
        put :update, :id => @user.id, :user => {title: 'some title', text: 'some text'} # Add here some attributes for the model
        expect(response).to redirect_to(user_path(@user)) # Put the right show path here
      end

      it "sets a flash message" do
        put :update, :id => @user.id, :user => {title: 'some title', text: 'some text'} # Add here some attributes for the model
        expect(flash[:notice]).to be == 'User was successfully updated.' # Your flash message here
      end
    end

    context "the update fails" do
      before(:each) do
        expect(@user).to receive(:update).and_return(false)
        expect(User).to receive(:find).with(@user.id.to_s).and_return(@user)
      end

      it "renders the 'edit' action" do
        put :update, :id => @user.id, :user => {title: 'some title', text: 'some text'} # Add here some attributes for the model
        expect(response).to render_template(:edit)
      end

      it "assigns @user" do
        put :update, :id => @user.id, :user => {title: 'some title', text: 'some text'} # Add here some attributes for the model
        expect(assigns(:user)).to_not be_nil
      end
    end
  end 

  describe "DELETE 'destroy'" do
    before(:each) do
      @user = users(:bob)
      expect(User).to receive(:find).with(@user.id.to_s).and_return(@user)
    end

    it "should delete the user" do
      expect(@user).to receive(:destroy).and_return(true)
      delete :destroy, :id => @user.id
    end

    it "should redirect to index page" do
      delete :destroy, :id => @user.id
      expect(response).to redirect_to(:users)
    end

    it "sets a flash message" do
      delete :destroy, :id => @user.id
      expect(flash[:notice]).to be == 'User was successfully destroyed.' # Your flash message here
    end
  end

end
