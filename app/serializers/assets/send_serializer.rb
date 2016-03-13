class Assets::SendSerializer < ::ApiSerializer
  attributes :fee, :metadata, :from, :to

  def from
    [$api.get_address(object.wif.wif)]
  end

  def metadata
    serialize_object(object, ::Assets::MetadataSerializer)
  end

  def to
    [{
      address: $api.get_address(object.wif.wif), 
      amount: object.amount - serialization_options[:amount].to_i, 
      assetId: object.asset_id
    },
    {
      address: serialization_options[:address], 
      amount: serialization_options[:amount], 
      assetId: object.asset_id
    }]
  end
end
