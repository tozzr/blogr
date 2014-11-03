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

  def logout
    session[:userId] = nil
    respond_to do |format|
      format.html { redirect_to root_path, notice: 'You have been logged out successfully.' }
      format.json { render :index, status: :ok }
    end
  end

end

