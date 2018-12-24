class UserReview < ApplicationRecord
  belongs_to :book
  belongs_to :user

  validates :rate, presence: true,
    length: {minimum: Settings.user_review.rate.min_length},
    length: {maximum: Settings.user_review.rate.max_length}
  validates :content,
    length: {maximum: Settings.user_review.content.max_length}
end
