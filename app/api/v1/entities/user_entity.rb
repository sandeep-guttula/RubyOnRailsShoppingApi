class V1::Entities::UserEntity < Grape::Entity
  expose :id
  expose :name
  expose :email
  expose :role
end
