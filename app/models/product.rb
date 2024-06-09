class Product < ApplicationRecord
  belongs_to :category
  belongs_to :seller , class_name: 'User'
  has_many :cart_items
  has_many :order_transactions


  validates :name, presence: true
  validates :description, presence: true
  validates :price, presence: true, numericality: { greater_than: 0 }
  validates :category, presence: true
  validates :seller, presence: true

end
