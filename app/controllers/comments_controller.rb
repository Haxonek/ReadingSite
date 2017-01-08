class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :authorized_user, only: [:destroy]

  def create
    @chapter = Chapter.find(params[:chapter_id])
    params[:comment][:chapter_id] = @chapter.id
    params[:comment][:book_id] = @chapter.book_id
    user_id = current_user.id
    # params[:comment][:user_id] = current_user
    @comment = current_user.comments.build(comment_params)
    # @comment.chapter_id = @chapter
    # @comment.book_id = @chapter.book_id
    # @comment.user_id = current_user.id
    # current_user.links.build

    if @comment.save
      # @comment.update_attributes(user_id: current_user.id)
      flash[:success] = "You comment was successfully posted"
      redirect_to chapter_path(@comment.chapter_id)
    else
      flash[:failure] = "There was an error posting your comment"
      redirect_to chapter_path(@comment.chapter_id)
    end
  end

  def destroy
		@comment = Comment.find(params[:id])
		@comment.destroy

    flash[:success] = "This comment was successfully deleted."
    redirect_to chapter_path(@comment.chapter_id)
  end

  private
  def comment_params
    params.require(:comment).permit(:content, :chapter_id, :book_id, :user_id, :rating)
  end

  def authorized_user
    @comment = current_user.comments.find_by(id: params[:id])
    redirect_to chapter_path(Comment.find_by(id: params[:id]).chapter_id), notice: "Not authorized to edit this comment" if @comment.nil?
  end
end
