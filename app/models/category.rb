class Category < ApplicationRecord
  has_many :books

  validates :name, presence: true,
    length: {maximum: Settings.category.name.max_length}
  validates :parent_id, presence: true
end
