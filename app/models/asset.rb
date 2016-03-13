class Asset < ActiveRecord::Base
  include SerializeHelper
  mount_uploader :picture, PictureUploader
  belongs_to :user
  belongs_to :wif

  def issue
    asset = serialize_object(self, ::Assets::IssueSerializer)
    response = $api.issue_asset(asset)
    if response[:txHex] && response[:assetId]
      self.update(tx_hex: response[:txHex], asset_id: response[:assetId])
      {asset_id: self.asset_id}
    else
      response
    end
  end

  def broadcast
    response = $api.broadcast($api.sign(self.wif.wif, self.tx_hex)) 
    self.update(is_issued: true, tx_ids: response[:txid].map{|t| t["txid"] }) if response[:txid].any? 
  end

  def send_asset(params)
    response = $api.send_asset(serialize_object(self, ::Assets::SendSerializer, params))
    if !response[:txHex]
      {error: response[:error] || I18n.t("js.info.something_went_wrong")}
    else
      response
    end
  end

end
