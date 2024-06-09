class User < ApplicationRecord
  has_secure_password

  has_many :products, foreign_key: :"seller_id"
  has_many :cart_items
  has_many :order_items

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true, confirmation: true
  validates :password_confirmation, presence: true

  validate :validate_password

  def validate_password
    if password.present? && password.length < 6
      errors.add(:password, "Password must be at least 6 characters")
    end
  end

end
