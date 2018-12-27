class BooksController < ApplicationController
  before_action :load_book, only: %i(show edit update)

  def index
    @books = Book.paginate page: params[:page],
      per_page: Settings.paginate.per_page
  end

  def new
    @book = Book.new
  end

  def edit; end

  def update
    if @book.update_attributes book_params
      flash[:success] = t "books.edit.profile_updated"
      redirect_to @book
    else
      render :edit
    end
  end

  def show; end

  def create
    @book = Book.new book_params
    if @book.save
      flash[:success] = t "books.create_book.create_success"
      redirect_to root_path
    else
      render :new
    end
  end

  def destroy; end

  private

  def load_book
    @book = Book.find_by id: params[:id]
    return if @book
    flash[:danger] = t "books.load_book.error_message"
    redirect_to root_path
  end

  def book_params
    params.require(:book).permit :category_id, :author_id, :publisher_id, :name,
      :content, :number_of_pages, :year, :number_of_books, :rate_points
  end
end
