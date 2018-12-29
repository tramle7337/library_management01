module BooksHelper
  def get_authors name
    Author.order(name)
  end

  def get_categories name
    Category.order(name).map{|category| [convert_name(category), category.id]}
  end

  def get_publishers name
    Publisher.order(name)
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
