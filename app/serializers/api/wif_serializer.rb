class Api::WifSerializer < ActiveModel::Serializer
  attributes :id, :address

  def address
    $api.to_address(object.wif)
  end
end
