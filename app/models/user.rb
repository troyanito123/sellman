class User < ApplicationRecord

  has_secure_password

  belongs_to :role
  has_many :products, dependent: :destroy
  has_many :sends, dependent: :destroy
  has_one_attached :avatar, dependent: :destroy

  before_save {self.email = email.downcase}

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :name, presence: true, length: {minimum: 2, maximum: 250}
  validates :email, presence: true, uniqueness: true, length: {minimum: 2,maximum: 250},
            format: {with: VALID_EMAIL_REGEX}
  validates :password, length: {minimum: 5}, allow_blank: true

  validate :avatar_validate

  attr_accessor :reset_token

  VALID_FORMAT_FOR_AVATAR = %w(jpg jpeg png).freeze
  def avatar_validate
    if avatar.attached?
      type = avatar.content_type.split('/').last
      if !VALID_FORMAT_FOR_AVATAR.include?(type)
        errors.add(:avatar, "The only support formats are jpg, jpeg and png...")
      end
    end
  end

  def admin?
    role.code == 'ADMIN'
  end

  def normal_user?
    role.code == 'USER'
  end

  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
               BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  def User.new_token
    SecureRandom.urlsafe_base64
  end

  def create_reset_digest
    self.reset_token = User.new_token
    update_attribute(:reset_digest,  User.digest(reset_token))
    update_attribute(:reset_send_at, Time.zone.now)
  end

  def send_password_reset_email
    UserMailer.password_reset(self).deliver_now
  end

  def password_reset_expired?
    reset_send_at < 2.hours.ago
  end

  def authenticated?(attribute, token)
    digest = send("#{attribute}_digest")
    return false if digest.nil?
    BCrypt::Password.new(digest).is_password?(token)
  end

end
