class Assets::MetadataSerializer < ::ApiSerializer
  attributes :assetId, :assetName, :issuer, :description, :urls, :userData

  def assetId
    object.id.to_s
  end

  def assetName
    object.name
  end

  def urls
    [picture().merge(name: :icon, dataHash: '')]
  end

  def userData
    meta = [
      { key: "Item ID",   value: object.id,   type: "Number" },
      { key: "Item Name", value: object.name, type: "String" },
    
    ]
    meta << {key: "Company", value: object.company_name, type: "String"} if object.company_name
    meta << {key: "Address", value: object.address,      type: "String"} if object.address

    { meta: meta }
  end

  private

  def picture
    if object.picture && object.picture.url
      { url: [ENV["DOMAIN_NAME"], object.picture.normal.url].join('/'), mimeType: object.picture.normal.content_type}
    else 
      {url: ENV["ASSET_ICON_DEFAULT"], mimeType: "image/png"}
    end
  end
end
