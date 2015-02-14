class UsersController < ApplicationController
  def index
    @user = User.find_by_session_token(@u.session_token)
  end

  def show
    if user = User.find(params[:id])
      if @u.session_token == user.session_token
        @user = User.find(params[:id])
      else
        @user = @u
        render :action => 'index'
      end
    else
      render :action => 'index'
    end
  end

  def new
    @user = User.new
  end

  def register
    @user = User.new
  end

  def user_register
    # render :plain => params
    @user = User.new(user_type_params)
    if @user.save
      sign_in(@user)
      redirect_to @user , :flash => { :success => "Successfully created user." } #:notice => "Successfully created major_type."
    else
      render :action => 'new'
    end
  end

  def edit
    if user = User.find(params[:id])
      if @u.session_token == user.session_token
        @user = User.find(params[:id])
      else
        @user = @u
        render :action => 'index'
      end
    else
      render :action => 'index'
    end
  end

  def update
    # @user = User.find(params[:id])
    @user = User.find(params[:id])
    if @user && @user.try(:authenticate, user_type_params[:password])
      if @user.update_attributes(user_type_params)
        redirect_to @user, :notice  => "Successfully updated user."
      else
        render :edit, :notice  => "Updated user faild."
      end
    else
      render :edit, :notice  => "Successfully updated user."
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to users_url, :notice => "Successfully destroyed user."
  end

  private  
  def user_type_params
    params.require(:user).permit(:id, :name, :email, :password, :password_confirmation)
  end  
end
