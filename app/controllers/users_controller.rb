class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @books = Book.where(user_id: @user).order("created_at DESC")
  end

  def adfree
    @user = User.find(current_user.id)
  end
end
