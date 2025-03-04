class CreateOrderTransactions < ActiveRecord::Migration[7.2]
  def change
    create_table :order_transactions do |t|
      t.references :product, null: false, foreign_key: true
      t.integer :quantity
      t.decimal :price

      t.timestamps
    end
  end
end
