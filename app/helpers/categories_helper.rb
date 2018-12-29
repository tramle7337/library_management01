module CategoriesHelper
  def find_category id
    Category.find_by id: id
  end
end
