class User < ApplicationRecord
  belongs_to :role
  has_many :products, dependent: :destroy
  has_one_attached :avatar, dependent: :destroy

  before_save {self.email = email.downcase}

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :name, presence: true, length: {minimum: 2, maximum: 250}
  validates :email, presence: true, uniqueness: true, length: {minimum: 2,maximum: 250},
            format: {with: VALID_EMAIL_REGEX}
  has_secure_password

  def admin?
    role.code == 'ADMIN'
  end

  def normal_user?
    role.code == 'USER'
  end

end
