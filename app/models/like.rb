class Like < ApplicationRecord
  belongs_to :book
  belongs_to :user

  scope :liked_by, ->(user_id){where user_id: user_id}
end
