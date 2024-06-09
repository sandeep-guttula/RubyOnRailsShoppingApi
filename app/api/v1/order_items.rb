require 'authentication_helpers'
require 'pagy'
require 'pagy/extras/metadata'

class Api::V1::OrderItems < Grape::API
  helpers AuthenticationHelpers

  resource :order_items do

    before do
      authenticate!
      if Current&.user&.role != 'buyer'
        error!({ error: "Buyers are only able to order items your role is #{Current.user.role}" }, 401)
      end

    end

    desc 'Get all user order items'
    get do
      order_items = OrderItem.joins(order_transaction: :product)
                             .select('order_items.id AS order_id, products.id AS product_id, products.name AS product_name, products.price AS product_price, order_transactions.price AS purchased_price, order_transactions.quantity, order_transactions.id AS transaction_id')
      present order_items
    end


    desc 'Add order item'
    params do
      requires :products_id, type: Integer
      requires :quantity, type: Integer
    end
    post :add do
      product = Product.find_by(id: params[:products_id])
      if product.nil?
        error!({ error: 'Product not found' }, 404)
      end

      transaction = OrderTransaction.new({
        product_id: product.id,
        quantity: params[:quantity],
        price: product.price * params[:quantity]
      })

      if transaction.save
        order_item = OrderItem.create!({
          order_transaction_id: transaction.id,
          user_id: Current.user.id
        })

        present order_item

      else
        error!({ error: transaction.errors.full_messages }, 500)
      end

    rescue ActiveRecord::RecordInvalid => e
      error!({ error: e.message }, 500)
    end

    desc 'Delete order item'
    params do
      requires :id, type: Integer
    end
    delete :delete do
      order_item = OrderItem.find_by(id: params[:id])
      if order_item.nil?
        error!({ error: 'Order item not found' }, 404)
      end

      if order_item.destroy
        present order_item
      else
        error!({ error: order_item.errors.full_messages }, 500)
      end
      rescue ActiveRecord::RecordInvalid => e
        error!({ error: e.message }, 500)
    end

  end

end