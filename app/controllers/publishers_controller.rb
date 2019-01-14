class PublishersController < ApplicationController
  before_action :load_publisher, only: :show

  def index
    @q = Publisher.ransack params[:q]
    @publishers = @q.result._page params[:page]
    respond_to do |format|
      format.html
      format.xls{send_data @publishers.to_xsl}
    end
  end

  def show; end

  private

  def load_publisher
    @publisher = Publisher.find_by id: params[:id]
    return if @publisher
    flash[:danger] = t ".error"
    redirect_to root_path
  end
end
