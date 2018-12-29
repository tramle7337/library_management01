class CategoriesController < ApplicationController
  before_action :load_category, except: %i(new create index)
  before_action :is_admin?, only: %i(edit destroy)

  def index
    @categories = Category._page params[:page]
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
      flash[:success] = t ".success"
      redirect_to categories_path
    else
      render :new
    end
  end

  def destroy
    if @category.destroy
      flash[:success] = t ".success"
    else
      flash[:danger] = t ".failed"
    end
    redirect_to categories_path
  end

  private

  def load_category
    @category = Category.find_by id: params[:id]
    return if @category
    flash[:danger] = t ".error"
    redirect_to categories_path
  end

  def category_params
    params.require(:category).permit :name, :parent_id
  end
end
