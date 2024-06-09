require 'authentication_helpers'

class Api::V1::Categorys < Grape::API
  helpers AuthenticationHelpers

  resource :categorys do

    before do
      authenticate!
      if Current&.user&.role != 'admin' or Current.user.role != 'seller'
        error!("#{Current.user.role} is not allowed to access categories", 403)
      end
    end

    desc 'Create a new category'
    params do
      requires :name, type: String
    end
    post do

      if Current&.user && Current.user.role != 'admin' or Current.user.role != 'seller'
        error!("#{Current.user.role} is not allowed to create categories", 403)
      end

      if Category.find_by(name: params[:name])
        error!('Category already exists', 500)
      end
      category = Category.create!({
        name: params[:name]
      })
      if category&.id
        {
          category: category,
          message: 'Category created successfully',
          status: 201
        }
      elsif category.errors
        error!(category.errors.full_messages, 500)
      end

    end

    desc 'Return list of categorys'
    get do
      Category.all
    end

    desc 'Return a specific category'
    params do
      requires :id, type: Integer
    end
    get ':id' do
      Category.find(params[:id])
    end

    desc 'Update a category'
    params do
      requires :id, type: Integer
      requires :name, type: String
    end
    put ':id' do
      category = Category.find(params[:id])
      if category.update({
        name: params[:name]
      })
        {
          category: category,
          message: 'Category updated successfully',
          status: 200
        }
      elsif category.errors
        error!(category.errors.full_messages, 500)
      end
    end

    desc 'Delete a category'
    params do
      requires :id, type: Integer
    end
    delete ':id' do
      category = Category.find(params[:id])
      if category.destroy
        {
          message: 'Category deleted successfully',
          status: 200
        }
      else
        error!(category.errors.full_messages, 500)
      end
    end
  end

end