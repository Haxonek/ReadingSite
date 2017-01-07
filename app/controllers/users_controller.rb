class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    # @books = Book.where(user_id: @user).order("created_at DESC")
    @users = @user.following_users #.books.order("created_at DESC").limit(5)

  end

  def adfree
    @user = User.find(current_user.id)
  end

  def follow
    @followable = User.find(params[:id])
    current_user.follow(@followable)
    redirect_to :back
  end

  def unfollow
    @followable = User.find(params[:id])
    current_user.stop_following(@followable)
    redirect_to :back
  end
end
