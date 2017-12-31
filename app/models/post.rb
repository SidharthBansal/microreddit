class Post < ApplicationRecord
  belongs_to :user
  default_scope -> { order(created_at: :desc) }
  validates :title, length: {maximum: 50, minimum: 3},
                    presence: true
  validates :description, length: {maximum: 500, minimum: 20},
                                      presence: true

  validates :user_id, presence: true
end
