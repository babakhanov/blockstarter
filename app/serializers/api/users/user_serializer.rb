class Api::Users::UserSerializer < ::ApiSerializer
  attributes :id, :email, :name, :company_name, :address
  has_many :wifs, each_serializer: Api::WifSerializer
end
