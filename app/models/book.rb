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
    length: {minimum: Settings.book.number.min_length}
  validates :year, presence: true
  validates :number_of_books, presence: true,
    length: {minimum: Settings.book.number.min_length}

  scope :newest, ->{order created_at: :DESC}
  scope :_page,
    ->(page){paginate page: page, per_page: Settings.paginate.per_page}
end
