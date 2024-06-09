class Api < Grape::API

  format :json

  mount Api::V1::Users
  mount Api::V1::UserSessions
  mount Api::V1::Categorys
  mount Api::V1::Products
  mount Api::V1::CartItems
  mount Api::V1::OrderItems

end