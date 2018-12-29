class BooksController < ApplicationController
  before_action :load_book, only: :show
  before_action :load_category, only: :index

  def index
    @books = Book.newest._page params[:page]
    @request_detail = current_request.request_details.build
  end

  def show; end

  private

  def load_category
    @categories = Category.newest
  end

  def load_book
    @book = Book.find_by id: params[:id]
    return if @book
    flash[:danger] = t ".error"
    redirect_to root_path
  end
end
