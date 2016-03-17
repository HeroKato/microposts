class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  include SessionsHelper
  include UsersHelper
  
  private
  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] = "Please log in."
      redirect_to login_url
    end
  end
  
  # 正しいユーザーかどうか確認
  def correct_user
    @user = User.find(params[:id])
    unless current_user?(@user)
      redirect_to(login_url)
      flash[:danger] = "Please log in as correct user."
    end
  end
end
