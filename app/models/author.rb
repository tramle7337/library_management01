class Author < ApplicationRecord
  has_many :books
  has_many :follows, as: :target, dependent: :destroy

  validates :name, presence: true
  validates :profile, presence: true

  scope :alphabet, ->{order name: :ASC}
  scope :_page,
    ->(page){paginate page: page, per_page: Settings.paginate.per_page}
end
