class CategoriesController < ApplicationController
  before_action :load_category, only: %i(show edit update)

  def index
    @categories = Category.paginate page: params[:page],
      per_page: Settings.paginate.per_page
  end

  def new
    @category = Category.new
  end

  def edit; end

  def update
    if @category.update_attributes category_params
      flash[:success] = t ".update"
      redirect_to @category
    else
      render :edit
    end
  end

  def show; end

  def create

    @category = Category.new category_params
    @category.parent_id = params[:category][:id]
    if @category.save
      flash[:success] = t ".create_success"
      redirect_to root_path
    else
      render :new
    end
  end

  private

  def load_category
    @category = Category.find_by id: params[:id]
    return if @category
    flash[:danger] = t ".error"
    redirect_to root_path
  end

  def category_params
    params.require(:category).permit :name, :parent_id
  end
end
