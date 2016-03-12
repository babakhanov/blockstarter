class Api::Users::UserSerializer < ActiveModel::Serializer
  attributes :id, :email, :name, :company_name
  has_many :wifs, each_serializer: Api::WifSerializer
end
