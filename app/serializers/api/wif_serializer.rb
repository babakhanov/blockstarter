class Api::WifSerializer < ActiveModel::Serializer
  attributes :id, :address

  def address
    $api.get_address(object.wif)
  end
end
