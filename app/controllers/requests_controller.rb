class RequestsController < ApplicationController
  before_action :load_request, except: %i(show update index)
  before_action :is_admin?, only: %i(accept_request deny_request)
  before_action :check_quantity, only: %i(accept_request)

  def create; end

  def show
    @request_details = RequestDetail.load_request_details params[:id]
    return unless @request_details.blank?
    flash[:danger] = t ".dont_exist"
    redirect_to root_path
  end

  def update
    if current_request.update_attributes request_params
      flash[:info] = t ".created"
      session[:request_id] = nil
    else
      flash[:danger] = t ".failed"
    end
    redirect_to root_path
  end

  def index
    @requests = Request.newest._page params[:page]
    return if @requests
    flash[:danger] = t ".no_request"
    redirect_back fallback_location: root_path
  end

  def destroy
    if @request.destroy
      flash[:success] = t ".success"
    else
      flash[:danger] = t ".failed"
    end
    redirect_to requests_path
  end

  def accept_request
    if @request.accept!
      update_quantity
      flash[:success] = t ".success"
    else
      flash[:danger] = t ".failed"
    end
    redirect_back fallback_location: root_path
  end

  def edit
    respond_to do |format|
      format.js
      format.html
    end
  end

  def deny_request
    if @request.update_attributes deny_request_params
      @success = t ".success"
    else
      flash[:danger] = t ".failed"
    end
    respond_to do |format|
      format.js
    end
  end

  private

  def load_request
    @request = Request.find_by id: params[:id]
    return if @request
    flash[:danger] = t ".error"
    redirect_to root_path
  end

  def request_params
    params.require(:request).permit :from_day, :to_day
  end

  def deny_request_params
    params.require(:request).permit :note, :status
  end

  def check_quantity
    flag = 0
    @request.request_details.each do |request_detail|
      @request.books.each do |book|
        if request_detail.book_id == book.id && (book.number_of_books -
          request_detail.number).negative?
          flag -= 1
        end
      end
    end
    return if flag.zero?
    flash[:danger] = t(".run_out")
    redirect_to requests_path
  end

  def update_quantity
    @request.request_details.each do |request_detail|
      @request.books.each do |book|
        if request_detail.book_id == book.id
          book.number_of_books -= request_detail.number
          book.update_attribute(:number_of_books, book.number_of_books)
        end
      end
    end
  end
end
