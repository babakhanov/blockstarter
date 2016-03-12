class Assets::IssueSerializer < ::ApiSerializer
  attributes :issueAddress, :amount, :fee, :transfer, :metadata

  def metadata
    serialize_object(object, ::Assets::MetadataSerializer)
  end

  def issueAddress
    $api.get_address(object.wif.wif)
  end

  def transfer
    [{ address: $api.get_address(object.wif.wif), amount: object.amount}]
  end
end
