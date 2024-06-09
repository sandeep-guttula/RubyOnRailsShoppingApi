class OrderItem < ApplicationRecord
  belongs_to :order_transaction
  belongs_to :user

end
