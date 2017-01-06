class CommentsController < ApplicationController
  def create
    @chapter = Chapter.find(params[:chapter_id])
    params[:comment][:chapter_id] = @chapter.id
    params[:comment][:book_id] = @chapter.book_id
    @comment = Comment.new(comment_params)

    if @comment.save
      flash[:success] = "You comment was successfully posted"
      redirect_to chapter_path(@comment.chapter_id)
    else
      flash[:failure] = "There was an error posting your comment"
      render 'show'
    end
  end

  def destroy
    @comment.destroy

    flash[:success] = "This comment was successfully deleted."
    redirect_to chapter_path(@comment.chapter_id)
  end

  private
  def comment_params
    params.require(:comment).permit(:content, :chapter_id, :book_id, :user_id, :rating)
  end
end
