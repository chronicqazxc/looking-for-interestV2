class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    # render :plain => params
    @user = User.new(user_type_params)
    if @user.save
      redirect_to @user , :flash => { :success => "Successfully created major_type." } #:notice => "Successfully created major_type."
    else
      render :action => 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_type_params)
      redirect_to @user, :notice  => "Successfully updated user."
    else
      render :action => 'edit', :notice  => "Updated major_type faild."
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to users_url, :notice => "Successfully destroyed major_type."
  end

  private  
  def user_type_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end  
end
