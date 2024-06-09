module AuthenticationHelpers
  def authenticate!
    header = request.headers['authorization']
    token = header.split(' ').last if header
    data = JWT.decode(token, "my$ecretK3")
    puts "data: #{data[0]["user_id"]}"
    Current.user = User.find(data[0]["user_id"])
  rescue JWT::DecodeError
    error!('Unauthorized ', 401)

  end

  def current_user
    Current.user
  end
end