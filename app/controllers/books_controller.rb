class BooksController < ApplicationController
  before_action :set_book, only: [:show, :edit, :update, :destroy]
  before_action :set_chapters, only: [:show]
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_action :authorized_user, only: [:edit, :update, :destroy]

  # GET /books
  # GET /books.json
  def index
    if params[:query].present?
      @items = params[:query].split(' ') # array of search items
      sql_query = "" # set up sql query

      @items.each do |item| # set up to search each word
        sql_query = sql_query + "(title LIKE \"%#{item}%\" OR description LIKE \"%#{item}%\" OR tags LIKE \"%#{item}%\") AND "
      end

      sql_query = sql_query.chomp(' AND ') # remove extra AND
      # actually search database for list
      @books = Book.all.where(sql_query).paginate(:page => params[:page], per_page: 10)
    else
      @books = Book.all.paginate(:page => params[:page], per_page: 10)
    end

    @route_with_scope = books_path
  end

  # GET /books/recent
  def recent
    # @books = Book.recent.paginate(:page => params[:page], per_page: 15)
    if params[:query].present?
      @items = params[:query].split(' ') # array of search items
      sql_query = "" # set up sql query

      @items.each do |item| # set up to search each word
        sql_query = sql_query + "(title LIKE \"%#{item}%\" OR description LIKE \"%#{item}%\" OR tags LIKE \"%#{item}%\") AND "
      end

      sql_query = sql_query.chomp(' AND ') # remove extra AND
      # actually search database for list
      @books = Book.recent.where(sql_query).paginate(:page => params[:page], per_page: 10)
    else
      @books = Book.recent.paginate(:page => params[:page], per_page: 10)
    end

    @route_with_scope = recent_books_path
    render 'index'
  end

  # GET /books/completed
  def completed
    # @books = Book.completed.paginate(:page => params[:page], per_page: 15)
    if params[:query].present?
      @items = params[:query].split(' ') # array of search items
      sql_query = "" # set up sql query

      @items.each do |item| # set up to search each word
        sql_query = sql_query + "(title LIKE \"%#{item}%\" OR description LIKE \"%#{item}%\" OR tags LIKE \"%#{item}%\") AND "
      end

      sql_query = sql_query.chomp(' AND ') # remove extra AND
      # actually search database for list
      @books = Book.completed.where(sql_query).paginate(:page => params[:page], per_page: 10)
    else
      @books = Book.completed.paginate(:page => params[:page], per_page: 10)
    end

    @route_with_scope = completed_books_path
    render 'index'
  end

  # GET /books/short
  def short
    # @books = Book.short.paginate(:page => params[:page], per_page: 15)
    if params[:query].present?
      @items = params[:query].split(' ') # array of search items
      sql_query = "" # set up sql query

      @items.each do |item| # set up to search each word
        sql_query = sql_query + "(title LIKE \"%#{item}%\" OR description LIKE \"%#{item}%\" OR tags LIKE \"%#{item}%\") AND "
      end

      sql_query = sql_query.chomp(' AND ') # remove extra AND
      # actually search database for list
      @books = Book.short.where(sql_query).paginate(:page => params[:page], per_page: 10)
    else
      @books = Book.short.paginate(:page => params[:page], per_page: 10)
    end

    @route_with_scope = short_books_path
    render 'index'
  end

  # GET /books/1
  # GET /books/1.json
  def show
  end

  # GET /books/new
  def new
    if user_signed_in?
      @book = Book.new
    else
      flash[:failure] = "You must be signed up to make a post.  Create an account now!"
      redirect_to new_user_registration_path
    end
  end

  # GET /books/1/edit
  def edit
  end

  # POST /books
  # POST /books.json
  def create
    # params[:book][:chapters_attributes][:user_id] = 6
    @book = current_user.books.build(book_params)

    if @book.save
      update_volumes_count
      update_tags
      flash[:success] = "This book was successfully created."
      redirect_to @book
    else
      flash["failure"] = "There was a problem creating your book."
      render 'new'
    end
  end

  # PATCH/PUT /books/1
  # PATCH/PUT /books/1.json
  def update
    if @book.update(book_params)
      update_volumes_count
      update_tags
      flash[:success] = "Book was successfully updated."
      redirect_to @book
    else
      flash[:failure] = "There was a problem updating your book."
      render 'edit'
    end
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

    def update_tags
      set_chapters
      book_tags = ""
      # we'll take all the tags from chapters and add to book_tag
      @chapters.each do |chapter|
        if book_tags.empty?
          book_tags = chapter.tags
        else
          tags = chapter.tags.split(', ')
          tags.each do |tag|
            # checks if book_tags contains tag, case insensitive
            unless book_tags =~ /#{tag}/i
              book_tags = book_tags + ", " + tag
            end
          end
          # book_tags = book_tags + ", " + chapter.tags
        end
      end
      @book.update_attributes(tags: book_tags)
    end

    def authorized_user
      @book = current_user.books.find_by(id: params[:id])
      redirect_to books_path, notice: "Not authorized to edit this nook" if @book.nil?
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def book_params
      params.require(:book).permit(:title, :description, :complete, :volumes, :user_id, chapters_attributes: [:id, :user_id, :title, :description, :tags, :content, :_destroy])
    end
end
