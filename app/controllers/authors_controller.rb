class AuthorsController < ApplicationController
  before_action :load_author, only: %i(show edit update)

  def index
    @authors = Author.paginate page: params[:page],
      per_page: Settings.paginate.per_page
  end

  def new
    @author = Author.new
  end

  def edit; end

  def update
    if @author.update_attributes author_params
      flash[:success] = t ".profile_updated"
      redirect_to @author
    else
      render :edit
    end
  end

  def show; end

  def create
    @author = Author.new author_params
    if @author.save
      flash[:success] = t ".create_success"
      redirect_to @author
    else
      render :new
    end
  end

  private

  def load_author
    @author = Author.find_by id: params[:id]
    return if @author
    flash[:danger] = t "authors.load_author.error_message"
    redirect_to root_path
  end

  def author_params
    params.require(:author).permit :name, :profile, :picture
  end
end
