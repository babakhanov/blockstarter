class Assets::MetadataSerializer < ::ApiSerializer
  attributes :assetId, :assetName, :issuer, :description, :urls

  def assetId
    object.id
  end

  def assetName
    object.name
  end

  def urls
    [picture().merge(name: :icon, dataHash: '')]
  end

  private

  def picture
    if object.picture
      { url: [ENV["DOMAIN_NAME"], object.picture.normal.url].join('/'), mimeType: object.picture.normal.content_type}
    else 
      {url: ENV["ASSET_ICON_DEFAULT"], mimeType: "image/png"}
    end
  end
end
