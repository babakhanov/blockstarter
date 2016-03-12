class Api::WifSerializer < ::ApiSerializer
  attributes :id, :address

  def address
    $api.get_address(object.wif)
  end
end
