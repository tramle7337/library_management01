class Admin::BooksController < ApplicationController
  before_action :load_book, except: %i(new create index)
  before_action :load_categories, only: %i(new edit index)
  before_action :is_admin?, only: %i(edit destroy)

  def index
    @books = Book.newest.search_book(params[:search])
      ._page params[:page]
    respond_to do |format|
      format.html
      format.xls{send_data @books.to_xsl}
    end
  end

  def new
    @book = Book.new
  end

  def edit; end

  def update
    if @book.update_attributes book_params
      flash[:success] = t ".update"
      redirect_to @book
    else
      render :edit
    end
  end

  def show; end

  def create
    @book = Book.new book_params
    if @book.save
      flash[:success] = t ".success"
      redirect_to admin_books_path
    else
      render :new
    end
  end

  def destroy
    if @book.destroy
      flash[:success] = t ".success"
    else
      flash[:danger] = t ".failed"
    end
    redirect_to admin_books_path
  end

  private

  def load_categories
    @categories = Category.alphabet
  end

  def load_book
    @book = Book.find_by id: params[:id]
    return if @book
    flash[:danger] = t ".error"
    redirect_to admin_books_path
  end

  def book_params
    params.require(:book).permit :category_id, :author_id, :publisher_id, :name,
      :content, :number_of_pages, :year, :number_of_books, :rate_points
  end
end
