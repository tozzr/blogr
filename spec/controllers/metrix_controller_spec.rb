require 'rails_helper'

describe MetrixController do
  
  before(:each) do
  end

  describe "CRUD POST click" do
    before(:each) do
      @click = Metrix::Click.new
      allow(Metrix::Click).to receive(:new).and_return(@click)
      allow(@click).to receive(:save).and_return(true)
        
      @params = {"body" => "test", "key" => "value"}
    end
    
    it "should build a new click" do
      expect(@click).to receive(:save)
      do_post
    end

    def do_post format = 'json'
      post 'click', :click => @params, :format => format
    end
  end

end