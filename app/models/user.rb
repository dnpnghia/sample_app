class User < ApplicationRecord
  validates :name, :email, :password, :password_confirmation, presence: true
  validates :name, :password,
            length: {minimum: Settings.user.password.min_length}
  validates :email, uniqueness: true
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i.freeze
  validates :email, format: {with: VALID_EMAIL_REGEX}
  has_secure_password

  def self.digest string
    cost = if ActiveModel::SecurePassword.min_cost
             BCrypt::Engine::MIN_COST
           else
             BCrypt::Engine.cost
           end
    BCrypt::Password.create string, cost: cost
  end
end
