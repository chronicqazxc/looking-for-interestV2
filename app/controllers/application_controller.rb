class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  include SessionsHelper

  before_filter :get_user , :except => "login"

  def get_user
  	if session[:session_token]
  		@u = User.find_by_session_token(session[:session_token])
  	else
  		redirect_to :controller => "session", :action => "login"
  	end
  end
end
