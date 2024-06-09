require 'authentication_helpers'

class Api::V1::UserSessions < Grape::API

  helpers AuthenticationHelpers

  resource :user_sessions do
    desc 'Create a new users.rb session'
    params do
      requires :email, type: String
      requires :password, type: String
    end
    post :login do
      user = User.find_by(email: params[:email])
      if user && user.authenticate(params[:password])

        payload = { user_id: user.id, exp: Time.now.to_i + 4 * 3600 }

        @token = JWT.encode(payload, "my$ecretK3")
        # cookies[:token] = @token
        if @token
          present access_token: @token, name: user.name, email: user.email
        end
      else
        error!('Unauthorized InValid Email or Password', 401)
      end
    end

    before do
      authenticate!
    end

    desc 'Destroy a users.rb session'
    delete :logout do
      # cookies.delete(:token)
      present message: 'Logged out successfully', status: 200
    end
  end
end