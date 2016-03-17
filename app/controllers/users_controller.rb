class UsersController < ApplicationController
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy, :following, :followers]
  before_action :correct_user, only:[:edit, :update]
  before_action :user_find, only:[:show, :following, :followers]
  
  def index
    @users = User.page(params[:page]).per(5).order(:id)
  end
  
  def show
    @microposts = @user.microposts.order(created_at: :desc).page(params[:page]).per(5).order(:id)
  end
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Welcome to the Sample App!"
      redirect_to @user
    else
      render 'new'
    end
  end
  
  def edit
  end
  
  def update
    if @user.update(user_params)
      flash[:success] = "Profile updated !"
      redirect_to @user
    else
      render 'edit'
    end
  end
  
  def following
    @title = "Following"
    @users = @user.following_users.page(params[:page]).per(5).order(:id)
    render 'show_follow'
  end
  
  def followers
    @title = "Followers"
    @users = @user.follower_users.page(params[:page]).per(5).order(:id)
    render 'show_follow'
  end
  
  private
  def user_params
    params.require(:user).permit(:name, :email, :profile, :location, :password, :password_confirmation)
  end
  
end
