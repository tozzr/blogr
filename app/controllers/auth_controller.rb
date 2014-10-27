class AuthController < ApplicationController
  
  def index
  end

  def login
    user = Blog::Security.authenticate(params[:username],params[:password])
    if (user)
      session[:userId] = user.id
      redirect_to articles_path
    else
      render "index"
    end
  end

end

