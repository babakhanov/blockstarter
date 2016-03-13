class Api::WifSerializer < ::ApiSerializer
  attributes :id, :address, :balance

  def balance
    $api.getbalance(object.address)
  end

end
