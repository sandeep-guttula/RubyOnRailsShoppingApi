class CartItem < ApplicationRecord
  belongs_to :user, foreign_key: 'users_id'
  belongs_to :product, foreign_key: 'products_id'

  validates :users_id, presence: true
  validates :products_id, presence: true
  validates :quantity, presence: true
end
