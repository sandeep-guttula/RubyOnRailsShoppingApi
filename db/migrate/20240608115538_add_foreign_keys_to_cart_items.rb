class AddForeignKeysToCartItems < ActiveRecord::Migration[7.2]
  def change
    add_foreign_key :cart_items, :users, column: :users_id
    add_foreign_key :cart_items, :products, column: :products_id
  end
end
