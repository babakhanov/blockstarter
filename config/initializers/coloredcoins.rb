require 'net/http'

network = Coloredcoins::TESTNET
Bitcoin.network = :testnet3
Coloredcoins.network = Coloredcoins::TESTNET
api_version = 'v3' # defaults to 'v3'
$api = Coloredcoins::API.new(network, api_version)
$address = ActiveSupport::JSON.decode(File.read("./colu/address.json"))
$asset = ActiveSupport::JSON.decode(File.read("./colu/asset.json"))
$key = Bitcoin::Key.new($address["priv"])
uri = URI.parse("http://testnet.api.coloredcoins.org:80/v3/issue")   

res = Net::HTTP.new(uri.host, uri.port).start do |client|
  request = Net::HTTP::Post.new(uri.path)
  request.body = $asset.to_json
  request["Content-Type"] = "application/json"
  client.request(request)
end

$tx = ActiveSupport::JSON.decode(res.body)

$transaction = Coloredcoins::MultisigTx.build($tx["txHex"]){|tx| tx.m = 1; tx.pub_keys = [$address["pub"]] }
#$tx = $api.issue_asset($asset)
#$key = Bitcoin::Key.from_base58("KxjT1Q2H6MqheA6xnwKB9QJGddTAUD6KMtNpuvqvcnxpszG1mJKn")
