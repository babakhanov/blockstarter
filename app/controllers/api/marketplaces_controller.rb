class Api::MarketplacesController < ApplicationController
  respond_to :json
  include SerializeHelper

  def show
    @assets = Asset.where("amount >=?", 1).where(is_published: true, is_issued: true).where.not(user_id: current_user.try(:id))
    respond_with @assets
  end
end
