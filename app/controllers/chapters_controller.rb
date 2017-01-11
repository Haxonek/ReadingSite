class ChaptersController < ApplicationController
  before_action :set_chapter, only: [:show, :destroy]
  before_action :authenticate_user!, except: [:show]
  before_action :authorized_user, only: [:destroy]

  def show
    # Compensate for books#create method
    if @chapter.user_id.nil? || @chapter.user_id == 0 # default value
      @chapter.update_attributes(user_id: Book.find(@chapter.book_id).user_id)
    end # otherwise user_id is already set

    renderer =  Redcarpet::Render::HTML.new(filter_html: true, no_images: true,
                prettify: true)
    @markdown = Redcarpet::Markdown.new(renderer, extensions =
                {no_intra_emphasis: true, highlight: true, underline: true,
                autolink: true})

    @comments = Comment.all.where(book_id: @chapter.book_id, chapter_id: @chapter)

    @comment = Comment.new
  end

  # DELETE /chapter/1
  # DELETE /chapter/1.json
  def destroy
    @chapter.destroy
    # update volumes value
    @book.update_attributes(volumes: Chapter.all.where(book_id: @book).count)

    flash[:success] = "This book was successfully deleted."
    redirect_to book_path(@chapter.book_id)
  end

  private
  def set_chapter
    @chapter = Chapter.find(params[:id])
  end

  def authorized_user
    @chapter = current_user.chapters.find_by(id: params[:id])
    redirect_to user_path(@chapter.user_id), notice: "Not authorized to edit this chapter" if @chapter.nil?
  end
end
