require 'authentication_helpers'
require 'pagy'
require 'pagy/extras/metadata'


class Api::V1::Users < Grape::API

  helpers AuthenticationHelpers
  include Pagy::Backend

  helpers do
    include Pagy::Backend
  end


  resource :users do

    # POST /users endpoint (SignUp)
    desc 'Create a new users.rb'
    params do
      requires :name, type: String
      requires :email, type: String
      requires :password, type: String
      requires :password_confirmation, type: String
      requires :role, type: String
    end
    post :signup do
      user = User.create!({
        name: params[:name],
        email: params[:email],
        password: params[:password],
        password_confirmation: params[:password_confirmation],
        role: params[:role]
      })
      if user&.id
        @token = JWT.encode({user_id:user.id }, "my$ecretK3")
        payload = { user_id: user.id, exp: Time.now.to_i + 4 * 3600 }

        @token = JWT.encode(payload, "my$ecretK3")
        # cookies[:token] = @token
        if @token
          present access_token: @token, name: user.name, email: user.email
        end
      end
      rescue ActiveRecord::RecordInvalid => e
        error!(e.message, 500)

    end


    # Authenticate users.rb before accessing this endpoint
    before do
      authenticate!
    end

    get :test do
      authenticate!
    end

    desc 'Return list of users'
    params do
      optional :page, type: Integer, default: 1
      optional :items, type: Integer, default: 10
    end
    get do
      if Current.user && Current.user.role == 'admin'
        pagy, users = pagy(User.all, page: params[:page], items: params[:items])
        users
      else
        error!('403 Forbidden role should be admin', 403)
      end
    end

    desc "Get Current User"
    get :current_user do
      Current.user
    end
  end

end