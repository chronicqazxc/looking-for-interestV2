class SessionController < ApplicationController
  def login
  end

  def create
    render :plain => params
  	@user = User.find_by_email(params[:session][:email])
  	if @user && @user.authenticate(params[:session][:password])
  		sign_in(@user)
  		redirect_to root_path
  	else
  		render "login"
  	end
  end

  def destroy
  end
end
