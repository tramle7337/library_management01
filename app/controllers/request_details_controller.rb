class RequestDetailsController < ApplicationController
  before_action :load_request, only: [:create, :update, :destroy]
  before_action :load_request_detail, only: [:update, :destroy]

  def create
    @request_detail = @request.request_details.find_by book_id:
      request_detail_params[:book_id]
    if @request_detail
      flash[:info] = t ".request_existed"
    else
      @request_detail = @request.request_details.build request_detail_params
    end
    check_request_details
    @request.save
    session[:request_id] = @request.id
    redirect_to root_path
  end

  def update
    if @request_detail.update_attributes request_detail_params
      flash[:info] = t ".success"
    else
      flash[:danger] = t ".failed"
    end
    redirect_back fallback_location: root_path
  end

  def destroy
    if @request_detail.destroy
      flash[:success] = t ".success"
    else
      flash[:danger] = t ".failed"
    end
    redirect_back fallback_location: root_path
  end

  private

  def request_detail_params
    params.require(:request_detail).permit :number, :book_id
  end

  def load_request
    @request = current_request
    return if @request
    flash[:danger] = t ".must_login"
    redirect_to login_path
  end

  def load_request_detail
    @request_detail = @request.request_details.find_by id: params[:id]
    return if @request_detail
    flash[:danger] = t ".error"
    redirect_to root_path
  end

  def check_request_details
    return if @request.request_details.present?
    flash[:danger] = t ".blank"
    redirect_to root_path
  end
end
