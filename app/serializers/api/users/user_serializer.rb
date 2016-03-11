class Api::Users::UserSerializer < ActiveModel::Serializer
  attributes :id, :email
  has_many :wifs, each_serializer: Api::WifSerializer
end
