class TicketsSerivice

  def create_tiket(options)
    asset = {
      issueAddress: options[:issue_address], 
      amount: options[:amount], 
      fee: 1000, 
      metadata: { 
        assetName: options[:name]
      } 
    }
    @api.issue_asset(asset)
  end

  def initialize
    network = Coloredcoins::TESTNET
    api_version = 'v3'
    @api = Coloredcoins::API.new(network, api_version)
  end
end
