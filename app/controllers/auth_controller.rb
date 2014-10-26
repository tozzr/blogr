class AuthController < ApplicationController
  
  def index
  end

  def login
    user = User.authenticate(params[:username],params[:password])
    if (user)
      session[:userId] = user.id
      redirect_to articles_path
    else
      render "index"
    end
  end

end

