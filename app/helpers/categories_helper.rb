module CategoriesHelper
  def find_category id
    if Category.find_by id: id
      Category.find_by id: id
    else
      flash[:danger] = t(".cant_find")
      redirect_to categories_path
    end
  end

  def load_categories name
    Category.order(name).map{|category| [convert_name(category), category.id]}
  end

  private

  def convert_name category
    if category.parent_id.present?
      "#{category.category.name}/#{category.name}"
    else
      category.name
    end
  end
end
