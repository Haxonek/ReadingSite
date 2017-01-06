class BooksController < ApplicationController
  before_action :set_book, only: [:show, :edit, :update, :destroy]
  before_action :set_chapters, only: [:show]

  # GET /books
  # GET /books.json
  def index
    @books = Book.all
  end

  def completed
    @books = Book.completed
    render 'index'
  end

  def short
    @books = Book.short
    render 'index'
  end

  # GET /books/1
  # GET /books/1.json
  def show
  end

  # GET /books/new
  def new
    @book = Book.new
  end

  # GET /books/1/edit
  def edit
  end

  # POST /books
  # POST /books.json
  def create
    @book = Book.new(book_params)

    if @book.save
      update_volumes_count
      flash[:success] = "This book was successfully created."
      redirect_to @book
    else
      flash["failure"] = "There was a problem creating your book."
      render 'new'
    end

    # respond_to do |format|
    #   if @book.save
    #     format.html { redirect_to @book, notice: 'Book was successfully created.' }
    #     format.json { render :show, status: :created, location: @book }
    #   else
    #     format.html { render :new }
    #     format.json { render json: @book.errors, status: :unprocessable_entity }
    #   end
    # end
  end

  # PATCH/PUT /books/1
  # PATCH/PUT /books/1.json
  def update

    if @book.update(book_params)
      update_volumes_count
      flash[:success] = "Book was successfully updated."
      redirect_to @book
    else
      flash[:failure] = "There was a problem updating your book."
      render 'edit'
    end
    # respond_to do |format|
    #   if @book.update(book_params)
    #     format.html { redirect_to @book, notice: 'Book was successfully updated.' }
    #     format.json { render :show, status: :ok, location: @book }
    #   else
    #     format.html { render :edit }
    #     format.json { render json: @book.errors, status: :unprocessable_entity }
    #   end
    # end
  end

  # DELETE /books/1
  # DELETE /books/1.json
  def destroy
    @book.destroy

    flash[:success] = "This book was successfully deleted."
    redirect_to books_url
    # respond_to do |format|
    #   format.html { redirect_to books_url, notice: 'Book was successfully destroyed.' }
    #   format.json { head :no_content }
    # end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_book
      @book = Book.find(params[:id])
    end

    def set_chapters
      @chapters = Chapter.all.where(book_id: @book)
    end

    def update_volumes_count
      @book.update_attributes(volumes: Chapter.all.where(book_id: @book).count)
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def book_params
      params.require(:book).permit(:title, :description, :complete, :volumes, :user_id, chapters_attributes: [:id, :title, :description, :tags, :content, :_destroy])
    end
end
