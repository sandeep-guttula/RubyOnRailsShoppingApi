class CreateCartItems < ActiveRecord::Migration[7.2]
  def change
    create_table :cart_items do |t|
      t.references :users, null: false, foreign_key: true
      t.references :products, null: false, foreign_key: true
      t.string :quantity

      t.timestamps
    end
  end


end
