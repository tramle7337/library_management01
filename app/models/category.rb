class Category < ApplicationRecord
  has_many :books
  has_many :parents, class_name: Category.name,
    foreign_key: :parent_id, dependent: :destroy
  belongs_to :category, class_name: Category.name, foreign_key: :parent_id,
    optional: true

  validates :name, presence: true,
    length: {maximum: Settings.category.name.max_length}

  scope :newest, ->{order created_at: :DESC}
  scope :alphabet, ->{order name: :DESC}
  scope :_page,
    ->(page){paginate page: page, per_page: Settings.paginate.per_page}

  def self.to_xsl options = {}
    CSV.generate(options) do |csv|
      csv << column_names
      all.each do |book|
        csv << book.attributes.values_at(*column_names)
      end
    end
  end
end
