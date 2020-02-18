class Product < ApplicationRecord
  belongs_to :user
  has_many_attached :images

  validates :title, presence: true, length: {minimum: 2, maximum: 250}
  validates :description, presence: true, length: {minimum: 2, maximum: 2500}
  validates :cost, presence: true, numericality: { only_integer: true, greater_than: 0, less_than: 999999 }

  validate :images_validate

  VALID_FORMAT_FOR_AVATAR = %w(jpg jpeg png)

  def images_validate
    images.each do |image|
      type = image.content_type.split('/').last
      if !VALID_FORMAT_FOR_AVATAR.include?(type)
        errors.add(:images, "The #{image.filename} is a format no support!")
      end
    end
  end

end
