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

  def buy
    if $api.find_for_tx_to_send(self.wif.wif, 5000).any?
      new_wif = Bitcoin::Key.new(Bitcoin.generate_key[0]).to_base58
      new_addr = $api.get_address(new_wif) 
      tx = $api.from_wif_to_addr(self.wif.wif, new_addr, ENV["ISSUE_FEE"].to_i)
      return tx if tx.class == Hash && tx[:error]
      if tx[:txid] && tx[:txid].any?
        res = self.send_asset({address: new_addr, amount: 1})
        response = $api.broadcast($api.sign(self.wif.wif, res[:txHex]))
        if response[:txid].any?
          self.update! amount: self.amount - 1 
          {asset: {wif: new_wif, asset_id: self.asset_id}}
        else
          {error: I18n.t("js.info.something_went_wrong")}
        end
      else
        {error: I18n.t("js.info.something_went_wrong")}
      end
    else
      {error: I18n.t("js.info.no_enough_funds")}
    end
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
