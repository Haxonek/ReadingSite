class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @users = @user.following_users

    @books =  Book.where(user_id: params[:id]).order("created_at DESC")
  end

  def your_stories
    @selections =  Book.where(user_id: params[:id]).order("created_at DESC")
  end

  def adfree
    # @user = User.find(current_user.id)
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
