class ChaptersController < ApplicationController
  before_action :set_chapter, only: [:show, :destroy]

  def show
  end

  # DELETE /chapter/1
  # DELETE /chapter/1.json
  def destroy
    @chapter.destroy

    flash[:success] = "This book was successfully deleted."
    redirect_to book_path(@chapter.book_id)
  end

  private
  def set_chapter
    @chapter = Chapter.find(params[:id])
  end
end
