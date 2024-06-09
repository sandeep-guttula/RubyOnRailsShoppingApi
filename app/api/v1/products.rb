require 'authentication_helpers'
require 'pagy'
require 'pagy/extras/metadata'

class Api::V1::Products < Grape::API

  helpers AuthenticationHelpers
  include Pagy::Backend

  helpers do
    include Pagy::Backend
    def product_params
      declared(params, include_missing: false).except(:id)
    end
  end

  before do
    authenticate!

  end

  resource :products do

    desc "Get all products"
    params do
      optional :page, type: Integer, default: 1
      optional :items, type: Integer, default: 5
    end
    get do
      Product.all
      pagy, products = pagy(Product.all, page: params[:page], items: params[:items])
      products
    end

    desc "Add product"
    params do
      requires :name, type: String
      requires :description, type: String
      requires :price, type: BigDecimal
      requires :category_id, type: Integer
      requires :seller_id, type: Integer
    end
    post :create do

      # Check if category and seller exist
      if Category.find_by(id: params[:category_id]).nil?
        error!({ error: 'Category not found' }, 404)
      end

      # Check if seller exist
      if User.find_by(id: params[:seller_id])&.role != 'seller'
        error!({ error: 'Seller not found' }, 404)
      end

      # Create product
      Product.create!(product_params)
    end


    desc 'Update a product'
    params do
      requires :id, type: Integer
      optional :name, type: String
      optional :description, type: String
      optional :price, type: BigDecimal
      optional :category_id, type: Integer
      optional :seller_id, type: Integer
    end
    put 'update/:id' do
      begin
        product = Product.find(params[:id])
        product.update!(product_params)
        product
      rescue ActiveRecord::RecordNotFound
        error!({ error: 'Product not found' }, 404)
      end
    end

    desc 'Return a product'
    params do
      requires :id, type: Integer, desc: 'Product ID'
    end
    get ':id' do
      begin
        Product.find(params[:id])
      rescue ActiveRecord::RecordNotFound
        error!({ error: 'Product not found', status: 404 })
      end
    end

    desc 'Delete a product'
    params do
      requires :id, type: Integer
    end
    delete ':id' do
      begin
        Product.find(params[:id]).destroy
      rescue ActiveRecord::RecordNotFound
        error!({ error: 'Product not found' }, 404)
      end
    end
  end

end