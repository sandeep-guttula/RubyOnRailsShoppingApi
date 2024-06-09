# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end


# User.create!({
#   name: 'Seller 1',
#   email: 'seller01@seller.com',
#   password: '123456789',
#   password_confirmation: '123456789',
#   role: 'seller'
# })
#
# User.create!({
#    name: 'Seller 2',
#    email: 'seller02@seller.com',
#    password: '123456789',
#    password_confirmation: '123456789',
#    role: 'seller'
#  })
#
# User.create!({
#   name: 'Seller 3',
#   email: 'seller03@seller.com',
#   password: '123456789',
#   password_confirmation: '123456789',
#   role: 'seller'
# })
#
# # Create a buyer
# User.create!({
#   name: 'Buyer 1',
#   email: 'buyer01@buyer.com',
#   password: '123456789',
#   password_confirmation: '123456789',
#   role: 'buyer'
# })
#
# User.create!({
#   name: 'Buyer 2',
#   email: 'buyer02@buyer.com',
#   password: '123456789',
#   password_confirmation: '123456789',
#   role: 'buyer'
# })
#
#
# User.create!({
#   name: 'Buyer 3',
#   email: 'buyer03@buyer.com',
#   password: '123456789',
#   password_confirmation: '123456789',
#   role: 'buyer'
# })

# Create a category
# sample_categories = [
#   "Electronics",
#   "Clothing & Apparel",
#   "Home & Kitchen",
#   "Beauty & Personal Care",
#   "Books & Media",
#   "Toys & Games",
#   "Sports & Outdoors",
#   "Health & Wellness",
#   "Pets",
#   "Automotive"
# ]
#
# sample_categories.each do |category_name|
#   Category.find_or_create_by!(name: category_name)
# end


# Create products
# Product.create!({ name: 'Product 1', description: 'Product 1 description', price: 100, category_id: 2, seller_id: 3 })
# Product.create!({ name: 'Product 2', description: 'Product 2 description', price: 200, category_id: 3, seller_id: 3 })
# Product.create!({ name: 'Product 3', description: 'Product 3 description', price: 300, category_id: 4, seller_id: 3 })
#
# Product.create!({ name: 'Product 4', description: 'Product 4 description', price: 400, category_id: 5, seller_id: 4 })
# Product.create!({ name: 'Product 5', description: 'Product 5 description', price: 500, category_id: 6, seller_id: 4 })
# Product.create!({ name: 'Product 6', description: 'Product 6 description', price: 600, category_id: 7, seller_id: 4 })
#
# Product.create!({ name: 'Product 7', description: 'Product 7 description', price: 700, category_id: 8, seller_id: 5 })
# Product.create!({ name: 'Product 8', description: 'Product 8 description', price: 800, category_id: 9, seller_id: 5 })
# Product.create!({ name: 'Product 9', description: 'Product 9 description', price: 900, category_id: 10, seller_id: 5 })

