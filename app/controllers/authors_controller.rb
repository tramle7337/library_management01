class AuthorsController < ApplicationController
  before_action :load_author, only: :show

  def index
    @q = Author.ransack params[:q]
    @authors = @q.result.alphabet._page params[:page]
    respond_to do |format|
      format.html
      format.xls{send_data @authors.to_xsl}
    end
  end

  def show; end

  private

  def load_author
    @author = Author.find_by id: params[:id]
    return if @author
    flash[:danger] = t ".error"
    redirect_to authors_path
  end
end
