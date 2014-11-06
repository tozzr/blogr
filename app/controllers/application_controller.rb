class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :populate_user_logged_in
  
  private 

  def populate_user_logged_in
    @user_logged_in = session[:userId] != nil
  end

  def check_authorization
    redirect_to auth_login_path if session[:userId] == nil
  end
end
