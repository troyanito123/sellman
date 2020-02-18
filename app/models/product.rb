class Product < ApplicationRecord
  belongs_to :user
  has_many_attached :images

  validates :title, presence: true, length: {minimum: 2, maximum: 250}
  validates :description, presence: true, length: {minimum: 2, maximum: 2500}
  validates :cost, presence: true, numericality: { only_integer: true, greater_than: 0, less_than: 999999 }

end
