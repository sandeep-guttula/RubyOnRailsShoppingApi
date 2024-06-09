require 'authentication_helpers'
require 'pagy'
require 'pagy/extras/metadata'

class Api::V1::CartItems < Grape::API
  helpers AuthenticationHelpers

  resource :cart_items do
    before do
      authenticate!
      if Current&.user&.role != 'buyer'
        error!({ error: "Buyers are only able to order. items your role is #{Current.user.role}" }, 401)
      end
    end

    desc 'Get all user cart items'
    get do
      cart_items = CartItem.joins(:product).select('cart_items.id AS cart_id , products.id AS product_id , cart_items.quantity, products.name, products.price').where(users_id: Current.user.id)
      present cart_items
    end

    desc 'Add cart item'
    params do
      requires :products_id, type: Integer
      requires :quantity, type: Integer
    end
    post :add do
      product = Product.find_by(id: params[:products_id])
      if product.nil?
        error!({ error: 'Product not found' }, 404)
      end

      cart_item = CartItem.create!({
        products_id: product.id,
        quantity: params[:quantity],
        users_id: Current.user.id
      })
    end

    desc 'Update cart item'
    params do
      requires :id, type: Integer
      requires :quantity, type: Integer
    end
    put :update do
      cart_item = CartItem.find_by(id: params[:id])
      if cart_item.nil?
        error!({ error: 'Cart item not found' }, 404)
      end

      cart_item.update!({
        quantity: params[:quantity]
      })
    end

    desc 'Delete cart item'
    params do
      requires :id, type: Integer
    end
    delete :delete do
      cart_item = CartItem.find_by(id: params[:id])
      if cart_item.nil?
        error!({ error: 'Cart item not found' }, 404)
      end

      cart_item.destroy
    end

  end

end