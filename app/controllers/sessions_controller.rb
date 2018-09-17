class SessionsController < ApplicationController
  
  def new
    @user = User.new
    render "new"
  end
  
  def create
    @user = User.find_by(username: params[:session][:username]).try(:authenticate, params[:session][:password])
    if @user
      session[:user_id] = @user.id
      redirect_to user_path(@user) 
    else
      flash.now[:danger] = "Wrong credentials! Please enter your username and password again."
      render "new"
    end
  end
  
  def destroy
    session[:user_id] = nil
    flash[:success] = "You have successfully logged out!"
    redirect_to articles_path
  end
end