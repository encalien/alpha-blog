class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :require_same_user, only: [:edit, :update, :destroy]
  before_action :require_admin, only: [:destroy]

  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      flash[:notice] = "Welcome to the Alpha Blog #{@user.firstname}!"
      session[:user_id] = @user.id
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
      flash[:success] = "Your account details were successfully updated!"
      redirect_to user_path(@user)
    else
      render 'edit'
    end
  end
  
  def index
    @users = User.paginate(page: params[:page], per_page: 5)
  end
  
  def destroy
    session[:user_id] = nil
    @user.destroy
    flash[:notice] = "User with username #{@user.username} was successfully deleted!"
    redirect_to users_path
  end
  
  def set_user
    @user = User.find(params[:id])
  end
  
  private
  
  def user_params
    params.require(:user).permit(:firstname, :lastname, :username, :email, :password, 
                                  :email_confirmation, :password_confirmation)
  end
    
  def require_same_user
    if @user != current_user
      flash[:danger] = "You can only edit or delete your own profile"
      redirect_to user_path(current_user)
    end
  end
  
  def require_admin
    if !current_user.admin?
      flash[:danger] = "Only admins can do this"
      redirect_to user_path(current_user)
    end
  end
end
