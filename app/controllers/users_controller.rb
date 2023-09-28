class UsersController < ApplicationController
  before_action :ensure_correct_user, only: [:edit, :update]

  def follows
    user = User.find(params[:id])
    @users = user.following_users
  end

 def followers
    user = User.find(params[:id])
    @users = user.follower_users
 end

  def show
    @user = User.find(params[:id])
    @book = Book.new
    @books = @user.books
    @following_users = @user.following_users
    @follower_users = @user.follower_users
  end

  def index
    @users = User.all
    @user = current_user
    @book = Book.new
  end

  def edit
    @user = User.find(params[:id])
    if @user.id == current_user.id
      flash[:notice] = "You have updated user successfully."
      render :edit
    else
      redirect_to user_path(current_user)
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = "You have updated user successfully."
      redirect_to user_path(current_user.id)
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end

  def ensure_correct_user
    @user = User.find(params[:id])
    unless @user == current_user
      redirect_to user_path(current_user)
    end
  end
end
