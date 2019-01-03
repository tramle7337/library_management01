class CommentsController < ApplicationController
  before_action :load_book, only: :create

  def index
    @comment = Comment.paginate page: params[:page],
      per_page: Settings.paginate.per_page
  end

  def new; end

  def create
    @comment = Comment.new comment_params
    @comment.user_id = current_user.id
    @comment.book_id = params[:book_id]
    if @comment.save
      flash[:success] = t ".create_success"
      redirect_to book_path @book
    else
      render :new
    end
  end

  private

  def comment_params
    params.require(:comment).permit :user_id, :book_id, :content
  end

  def load_book
    @book = Book.find_by id: params[:book_id]
    return if @book
    flash[:danger] = t "books.load_book.error_message"
    redirect_to root_path
  end
end
