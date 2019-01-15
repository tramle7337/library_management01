class BooksController < ApplicationController
  before_action :load_book, only: :show
  before_action :load_categories, only: :index

  def index
    @q = Book.ransack params[:q]
    @books = @q.result.newest._page params[:page]
    @request_detail = current_request.request_details.build
  end

  def show
    @comment = Comment.new
  end

  private

  def load_categories
    @categories = Category.alphabet
  end

  def load_book
    @book = Book.find_by id: params[:id]
    return if @book
    flash[:danger] = t ".error"
    redirect_to root_path
  end
end
