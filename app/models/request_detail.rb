class RequestDetail < ApplicationRecord
  belongs_to :book
  belongs_to :request

  validates :number, presence: true
end
