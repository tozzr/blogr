module Blog
  
  module Security

    def self.authenticate(username, password)
      user = User.find_by_username(username)
      if (user && user.password_hash == BCrypt::Engine.hash_secret(password, user.password_salt))
        user
      else
        nil
      end
    end

    def self.generate_salt
      BCrypt::Engine.generate_salt
    end

    def self.hash_secret (password, salt)
      BCrypt::Engine.hash_secret(password, salt)
    end

  end

end
