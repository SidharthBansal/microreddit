class Post < ApplicationRecord
  belongs_to :user
  default_scope -> { order(created_at: :desc) }
  validates :title, length: {maximum: 50, minimum: 3},
                    presence: true
  validates :description, length: {maximum: 500, minimum: 20},
                                      presence: true

  validates :user_id, presence: true
  mount_uploader :picture, PictureUploader
  validate :picture_size

  private

  # Validates the size of an uploaded picture
  def picture_size
    if picture.size > 5.megabytes
      errors.add(:picture, "should be less than 5MB")
    end
  end
end
