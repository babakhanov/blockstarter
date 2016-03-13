class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  respond_to :html, :json
  before_action :get_api

  private

  def get_api
    $api = ColoredCoins.new(:testnet3)
  end
end
