require 'rails_helper'

describe UsersController do
  fixtures :users

  before(:each) do
    @model = "User"
  end

  context "not logged in" do
    before(:each) do
      session[:userId] = nil
    end

    it_should_behave_like "redirect to login"
  end

  context "logged in" do
    before(:each) do
      session[:userId] = 1
    end

    it_should_behave_like "CRUD GET index"
    it_should_behave_like "CRUD GET show"
    it_should_behave_like "CRUD GET new"
    it_should_behave_like "CRUD POST create"
    it_should_behave_like "CRUD GET edit"
    it_should_behave_like "CRUD PUT update"
    it_should_behave_like "CRUD DELETE destroy"
  
  end
end
