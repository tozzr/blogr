require 'rails_helper'

class TestController < ApplicationController
  def index
    respond_to do |format|
      format.all { render :nothing => true, :status => 200 }
    end
  end
end

describe TestController do
  before do
    Rails.application.routes.draw do
      get "test/index", :controller => "test", :action => "index"
    end
  end

  after do
    Rails.application.reload_routes!
  end

  context "#user_logged_in" do
    it "should return false when not logged in" do
      session[:userId] = nil
      get :index
      expect(assigns['user_logged_in']).to be false
    end

    it "should return true when logged in" do
      session[:userId] = 1
      get :index
      expect(assigns['user_logged_in']).to be true
    end

  end

end
