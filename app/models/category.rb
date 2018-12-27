class Category < ApplicationRecord
  has_many :books
  has_many :subcategories, class_name: Category.name, foreign_key: :parent_id, dependent: :destroy
  has_one :parent, class_name: Category.name, foreign_key: :id

  validates :name, presence: true,
    length: {maximum: Settings.category.name.max_length}
  # validates :parent_id, presence: true
end
