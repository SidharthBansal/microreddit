class Post < ApplicationRecord
  validates :title, length: {maximum: 50, minimum: 10}
  belongs_to :user
end
