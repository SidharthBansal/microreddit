class Comment < ApplicationRecord
  belongs_to :post
  belongs_to :user
  validates :user_id, presence: true
  validates :post_id, presence: true
  validates :title, presence: true,
                  length: {maximum: 15, minimum: 5}
  validates :body, presence: true,
                  length: {maximum: 50, minimum: 5}

end
