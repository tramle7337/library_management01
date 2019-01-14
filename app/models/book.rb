class Book < ApplicationRecord
  belongs_to :category
  belongs_to :author
  belongs_to :publisher
  has_many :request_details, dependent: :destroy
  has_many :user_reviews, dependent: :destroy
  has_many :follows, as: :target, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy

  validates :name, presence: true,
    length: {maximum: Settings.book.name.max_length}
  validates :content, :category, presence: true,
    length: {maximum: Settings.book.content.max_length}
  validates :number_of_pages, presence: true,
    numericality: {only_integer: true, greater_than: Settings.book.page.min_num}
  validates :year, presence: true,
    numericality: {only_integer: true, greater_than: Settings.book.year.min_num}
  validates :number_of_books, presence: true,
    numericality: {
      only_integer: true, greater_than: Settings.book.num_book.min_num
    }

  acts_as_paranoid

  scope :newest, ->{order created_at: :DESC}
  scope :_page,
    ->(page){paginate page: page, per_page: Settings.paginate.per_page}

  ransack_alias :book_search,
    :name_or_author_name_or_category_name_or_publisher_name

  def self.to_xsl options = {}
    CSV.generate(options) do |csv|
      csv << column_names
      all.each do |book|
        csv << book.attributes.values_at(*column_names)
      end
    end
  end

  def liked_by? user
    likes.liked_by(user.id).present?
  end
end
