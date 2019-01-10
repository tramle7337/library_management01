module CategoriesHelper
  def find_category id
    if Category.find_by id: id
      Category.find_by id: id
    else
      flash[:danger] = t(".cant_find")
      redirect_to categories_path
    end
  end
end
