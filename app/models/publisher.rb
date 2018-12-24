class Publisher < ApplicationRecord
  has_many :books

  validates :name, presence: true,
    length: {maximum: Settings.publisher.name.max_length}
  validates :address, presence: true,
    length: {maximum: Settings.publisher.address.max_length}
end
