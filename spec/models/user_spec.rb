require 'rails_helper'

RSpec.describe User, :type => :model do
  fixtures :users

  describe "#authenticate" do

    it "succeds when correct username and password" do
      @bob = users(:bob)
      expect(User.authenticate('bob','pass1234')).to eq(@bob)
    end

    it "fails when no username and no password" do
      expect(User.authenticate('','')).to be nil
    end

    it "fails when correct username and no password" do
      expect(User.authenticate('bob','')).to be nil
    end

    it "fails when wrong username and correct password" do
      expect(User.authenticate('jack','abc1234')).to be nil
    end

    it "fails when wrong username and wrong password" do
      expect(User.authenticate('jack','xyz678')).to be nil
    end

  end

  describe "#encrypt_password" do
    
    it "when password present generate hash and encrypt password" do
      user = User.new(:username => 'bob', :password => 'pass1234')
      expect(user.encrypt_password).to eq(BCrypt::Engine.hash_secret(user.password, user.password_hash))
      
    end

  end


end
