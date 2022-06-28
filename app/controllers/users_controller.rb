class UsersController < ApplicationController
 before_action :authenticate_user!, only: [:show, :update, :edit, :index]
 
 
  def show
    @user = User.find(params[:id])
    @book = Book.new
    @books = @user.books
  end

  def index
    @users = User.all
    @book = Book.new
    @books = Book.all
  end

  def edit
    @user = User.find(params[:id])
    if @user == current_user
        render "edit"
    else
      redirect_to user_path(current_user)
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice]="You have updated user successfully."
      redirect_to user_path(current_user)
    else
      render :edit
    end
  end
  
  def authenticate
  redirect_to new_user_session  unless user_signed_in?
  end

  private
  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end

end