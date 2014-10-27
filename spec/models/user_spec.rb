require 'rails_helper'

RSpec.describe User, :type => :model do
  
  describe "#encrypt_password" do
    
    it "when password present generate hash and encrypt password" do
      user = User.new(:username => 'bob', :password => 'pass1234')
      expect(user.encrypt_password).to eq(BCrypt::Engine.hash_secret(user.password, user.password_hash))
      
    end

  end


end
