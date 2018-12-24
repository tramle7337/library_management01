class Author < ApplicationRecord
  has_many :books
  has_many :follows, as: :target, dependent: :destroy

  validates :name, presence: true
  validates :profile, presence: true
end
