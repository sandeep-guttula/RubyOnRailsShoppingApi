# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.2].define(version: 2024_06_09_080647) do
  create_table "cart_items", force: :cascade do |t|
    t.integer "users_id", null: false
    t.integer "products_id", null: false
    t.string "quantity"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["products_id"], name: "index_cart_items_on_products_id"
    t.index ["users_id"], name: "index_cart_items_on_users_id"
  end

  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "order_items", force: :cascade do |t|
    t.integer "order_transaction_id", null: false
    t.integer "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["order_transaction_id"], name: "index_order_items_on_order_transaction_id"
    t.index ["user_id"], name: "index_order_items_on_user_id"
  end

  create_table "order_transactions", force: :cascade do |t|
    t.integer "product_id", null: false
    t.integer "quantity"
    t.decimal "price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["product_id"], name: "index_order_transactions_on_product_id"
  end

  create_table "products", force: :cascade do |t|
    t.string "name", null: false
    t.text "description", null: false
    t.decimal "price", null: false
    t.integer "category_id", null: false
    t.integer "seller_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category_id"], name: "index_products_on_category_id"
    t.index ["seller_id"], name: "index_products_on_seller_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "password_digest"
    t.string "role"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "cart_items", "products", column: "products_id"
  add_foreign_key "cart_items", "products", column: "products_id"
  add_foreign_key "cart_items", "users", column: "users_id"
  add_foreign_key "cart_items", "users", column: "users_id"
  add_foreign_key "order_items", "order_transactions"
  add_foreign_key "order_items", "users"
  add_foreign_key "order_transactions", "products"
  add_foreign_key "products", "categories"
  add_foreign_key "products", "users", column: "seller_id"
end
