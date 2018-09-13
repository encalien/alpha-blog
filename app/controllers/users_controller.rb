class UsersController < ApplicationController
  before_action :set_user, only: [:index, :show, :edit, :update, :destroy]
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      flash[:notice] = "User was successfully created!"
      redirect_to user_path(@user)
    else
      render 'new'
    end
  end
  
  def show; end
  
  def edit; end
  
  def update
    if @user.update(user_params)
      flash[:notice] = "User details were successfully updated!"
      redirect_to user_path(@user)
    else
      render 'edit'
    end
  end
  
  def index; 
    @user
  end
  
  def destroy
    @user.destroy
    flash[:notice] = "User with username #{@user.username} was successfully deleted!"
    redirect_to users_path
  end
  
  def set_user
    @user = User.find(params[:id]=4)
    # @user = User.find(params[:id])
  end
  
  private
  
  def user_params
    params.require(:user).permit(:username, :email)
  end
end
