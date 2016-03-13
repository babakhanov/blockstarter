require 'net/http'
require 'bitcoin'

class ColoredCoins

  def initialize(network=:mainnet, api_v="v3")
    Bitcoin.network = network
    @network = network.to_sym
    @api_v = api_v
  end

  def from_wif_to_addr(wif, addr, amount, to_broadcast=true)
    txs = self.find_for_tx_to_send(wif, amount)
    return txs[:error] if txs.class == "Hash" && txs[:error] 
    params = [wif, addr, txs[0][:value], amount, ENV['ISSUE_FEE'], txs[0][:txid], txs[0][:index]].join(' ')
    txHex = `node #{Rails.root.to_s}/sign_js/from_wif_to_addr.js #{params}}`.chomp
    self.broadcast(txHex) if to_broadcast
  end

  def find_for_tx_to_send(wif, amount)
    utxos = self.addressinfo(self.get_address(wif))
    txs = utxos[:utxos].map{|a| a["value"] > amount ? {index: a["index"], value: a["value"], txid: a["txid"]} : nil}.compact
    txs.any? ? txs : {error: I18n.t("js.info.no_enough_funds")}
  end

  def issue_asset(asset, sign=true)
    make_request(api_url(:issue), asset)
  end

  def send_asset(asset)
    make_request(api_url(:sendasset), asset)
  end

  def broadcast(tx_hex)
    make_request(api_url(:broadcast), {txHex: tx_hex}) 
  end

  def get_address(wif)
    Bitcoin::pubkey_to_address(Bitcoin::Key.from_base58(wif).pub)
  end

  def sign(key, tx_hex)
    `node #{Rails.root.to_s}/sign_js/sign.js #{tx_hex.chomp} #{key.chomp}`.chomp
  end
  
  def addressinfo(address)
    make_request(api_url("addressinfo/#{address}"), '', '', 'Get') 
  end

  def getbalance(address, with_name=true)
    summ = self.addressinfo(address)[:utxos].map{|d| d["value"] }.sum
    with_name ? [summ, currency_name].join(" ") : summ
  end

  private

  def api_url(endpoint="")
    { mainnet: "http://api.coloredcoins.org:80/#{@api_v}/#{endpoint.to_s}",
      testnet3: "http://testnet.api.coloredcoins.org:80/#{@api_v}/#{endpoint.to_s}"
    }[@network]
  end

  def currency_name
    { mainnet: "BTC", testnet3: "tBTC" }[@network]
  end

  def make_request(path, data, endpoint='', method="Post")
    uri = URI.parse(path)   
    res = Net::HTTP.new(uri.host, uri.port).start do |client|
      request = "Net::HTTP::#{method}".constantize.new(uri.path)
      request.body = data.to_json unless method == "Get"
      request["Content-Type"] = "application/json"
      client.request(request)
    end
    ActiveSupport::JSON.decode(res.body).symbolize_keys
  end
end
