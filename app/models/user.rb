class User < ActiveRecord::Base
  has_many :articles
  
  attr_accessor :password
  before_save :encrypt_password

  def encrypt_password
    if password.present?
      self.password_salt = Blog::Security.generate_salt
      self.password_hash = Blog::Security.hash_secret(password, self.password_salt)
    end
  end
  
end
