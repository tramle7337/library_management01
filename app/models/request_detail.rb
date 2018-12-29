class RequestDetail < ApplicationRecord
  belongs_to :book
  belongs_to :request

  validates :number, presence: true,
    numericality: {only_integer: true, greater_than: 0}

  scope :load_request_details, ->(id){where(request_id: id)}
end
