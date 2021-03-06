class SessionController < ApplicationController
  def welcome
    # if session[:session_token]
    #   redirect_to root_path 
    # end
  end

  def register
    redirect_to :controller => "users", :action => "register" 
  end

  def login
    if @user = User.find_by(email: params[:session][:email]).try(:authenticate, params[:session][:password_digest])
      sign_in(@user)
      redirect_to root_path
    else
      render :action => "welcome", :note => "Login faild"
    end
  end

  def logout
    session[:session_token] = nil
    redirect_to root_path 
  end

  def destroy
  end

private  
  def session_params
    params.require(:session).permit(:email, :password_digest)
  end  
end
