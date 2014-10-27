require 'rails_helper'

describe Blog::Security do
  fixtures :users

  describe "#authenticate" do
    it "succeeds when correct username and password" do
      @bob = users(:bob)
      expect(Blog::Security.authenticate('bob','pass1234')).to eq(@bob)
    end

    it "fails when no username and no password" do
      expect(Blog::Security.authenticate('','')).to be nil
    end

    it "fails when correct username and no password" do
      expect(Blog::Security.authenticate('bob','')).to be nil
    end

    it "fails when wrong username and correct password" do
      expect(Blog::Security.authenticate('jack','abc1234')).to be nil
    end

    it "fails when wrong username and wrong password" do
      expect(Blog::Security.authenticate('jack','xyz678')).to be nil
    end
  end

  describe "#generate_salt" do
    it "generates a salt" do
      expect(Blog::Security.generate_salt).to_not be_nil
    end
  end

  describe "#hash_secret" do
    it "hash a password with given salt" do
      password = 'pass1234'
      salt = BCrypt::Engine.generate_salt
      expect(Blog::Security.hash_secret(password, salt)).to eq(BCrypt::Engine.hash_secret(password, salt))
    end
  end

end
