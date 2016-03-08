require 'net/http'
require 'bitcoin'

class ColoredCoins

  def initialize(network=:mainnet, api_v="v3")
    @network = network
    @api_v = api_v
  end

  def issue_asset(asset, sign=true)
    make_request(api_url(:issue), asset)
  end

  def broadcast(tx_hex)
    make_request(api_url(:broadcast), {txHex: tx_hex}) 
  end

  def sign(key, tx_hex)
    `node #{Rails.root.to_s}/sign_js/sign.js #{tx_hex.chomp} #{key.chomp}`.chomp
  end

  private

  def api_url(endpoint="")
    {
      mainnet: "http://api.coloredcoins.org:80/#{@api_v}/#{endpoint.to_s}",
      testnet: "http://testnet.api.coloredcoins.org:80/#{@api_v}/#{endpoint.to_s}"
    }[@network]
  end

  def make_request(path, data, endpoint='')
    uri = URI.parse(path)   
    res = Net::HTTP.new(uri.host, uri.port).start do |client|
      request = Net::HTTP::Post.new(uri.path)
      request.body = data.to_json
      request["Content-Type"] = "application/json"
      client.request(request)
    end
    ActiveSupport::JSON.decode(res.body).symbolize_keys
  end
end
