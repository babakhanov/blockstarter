network = Coloredcoins::TESTNET
Bitcoin.network = :testnet3
Coloredcoins.network = Coloredcoins::TESTNET
api_version = 'v3' # defaults to 'v3'
$api = Coloredcoins::API.new(network, api_version)
$address = ActiveSupport::JSON.decode(File.read("./colu/address.json"))
$asset = ActiveSupport::JSON.decode(File.read("./colu/asset.json"))
$tx = $api.issue_asset($asset)
$key = Bitcoin::Key.new($address["private_key"], $address["pub_key"])
$transaction = Coloredcoins::MultisigTx.build($tx[:txHex]){|tx| tx.m = 1; tx.pub_keys = [$address["pub_key"]] }
