class Post < ApplicationRecord
  validates :title, length: {maximum: 50, minimum: 10},
                    presence: true
  validates :description, length: {maximum: 500, minimum: 20},
                                      presence: true
  belongs_to :user
end
