class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      flash[:notice] = "Welcome to the Alpha Blog #{user.firstname}!"
      redirect_to user_path(@user)
    else
      render 'new'
    end
  end
  
  def show; 
    @user_articles = @user.articles.paginate(page: params[:page], per_page: 5)
  end
  
  def edit; end
  
  def update
    if @user.update(user_params)
      flash[:notice] = "Your account details were successfully updated!"
      redirect_to user_path(@user)
    else
      render 'edit'
    end
  end
  
  def index
    @users = User.paginate(page: params[:page], per_page: 5)
  end
  
  def login; 
    @user = User.find_by(username: params[:username]).try(:authenticate, params[:password])
  end
  
  def destroy
    @user.destroy
    flash[:notice] = "User with username #{@user.username} was successfully deleted!"
    redirect_to users_path
  end
  
  def set_user
     @user = User.find(params[:id])
  end
  
  private
  
  def user_params
    params.require(:user).permit(:firstname, :lastname, :username, :email, :password, :email_confirmation, :password_confirmation)
  end
end
