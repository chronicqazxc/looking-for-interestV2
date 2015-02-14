class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  include UsersHelper

  before_filter :get_user , :except => [:welcome, :login, :user_register, :register]

  def get_user
  	if session[:session_token]
      if User.find_by_session_token(session[:session_token])
        @u = User.find_by_session_token(session[:session_token])
      else
        redirect_to :controller => "session", :action => "welcome"
      end
  		
  	else
  		redirect_to :controller => "session", :action => "welcome"
  	end
  end
end
