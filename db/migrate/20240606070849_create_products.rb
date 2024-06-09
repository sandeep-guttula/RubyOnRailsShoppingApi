class CreateProducts < ActiveRecord::Migration[7.2]
  def change
    create_table :products do |t|
      t.string :name , null: false
      t.text :description, null: false
      t.decimal :price, null: false
      t.references :category, null: false, foreign_key: true
      t.references :seller, null: false, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end
