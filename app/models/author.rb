class Author < ApplicationRecord
  has_many :books
  has_many :follows, as: :target, dependent: :destroy

  validates :name, presence: true
  validates :profile, presence: true

  scope :alphabet, ->{order name: :ASC}
  scope :_page,
    ->(page){paginate page: page, per_page: Settings.paginate.per_page}
  scope :search_author, -> search {
    where("authors.name LIKE ?",
    "%#{search.strip}%") if search.present?
  }

  def self.to_xsl options = {}
    CSV.generate(options) do |csv|
      csv << column_names
      all.each do |author|
        csv << author.attributes.values_at(*column_names)
      end
    end
  end
end
