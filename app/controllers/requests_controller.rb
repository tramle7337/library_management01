class RequestsController < ApplicationController
  load_and_authorize_resource
  before_action :load_request, except: %i(update index)
  before_action :check_time_borrow, only: %i(update)
  before_action :load_request_details, only: %i(index)

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

  def edit
    respond_to do |format|
      format.js
      format.html
    end
  end

  private

  def load_request
    @request = Request.find_by id: params[:id]
    return if @request
    flash[:danger] = t ".error"
    redirect_to root_path
  end

  def load_request_details
    @request_details = RequestDetail.load_request_details params[:id]
  end

  def request_params
    params.require(:request).permit :from_day, :to_day, :note_user
  end

  def check_time_borrow
    return if params[:request][:from_day] < params[:request][:to_day]
    flash[:danger] = t ".error"
    redirect_to edit_request_path
  end
end
