class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :book

  validates :content, presence: true, allow_blank: false,
    length: {maximum: Settings.comment.content.max_length}
end
