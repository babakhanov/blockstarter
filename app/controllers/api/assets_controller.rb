class Api::AssetsController < ApiController
  def index
    @assets = cur_user.assets.order(created_at: :desc)
    respond_with @assets
  end

  def show
    respond_with @asset
  end

  def create
    @asset = Asset.new asset_params.merge(user_id: cur_user.id) 
    if @asset.save
      render json: @asset
    end
  end

  def update
    @asset = Asset.find(params[:id])
    if @asset.update asset_params
      respond_with @asset
    end
  end

  def destroy
    if @asset.delete
      render json: {id: params[:id]}
    end
  end

  def toggle
    @asset = Asset.find_by(user_id: cur_user.id, id: params[:asset_id])
    return if !@asset
    @asset.update(is_published: !@asset.is_published)
    render json: {is_published: @asset.is_published}
  end

  def issue
    @asset = Asset.find_by(user_id: cur_user.id, id: params[:asset_id])
    return if !@asset
    data = @asset.issue
    unless data[:error]
      @asset.broadcast
      respond_with @asset 
    else
      respond_with data
    end
  end

  def send_asset
    @asset = Asset.find(params[:asset_id])
    res = @asset.send_asset(send_asset_params)
    if res[:error]
      render json: res
    else
      response = $api.broadcast($api.sign(@asset.wif.wif, res[:txHex]))
      if response[:txid].any?
        @asset.update! amount: @asset.amount - send_asset_params[:amount].to_i
        render json: {asset: serialize_object(@asset, ::Api::AssetSerializer)}
      else
        render json: {error: I18n.t("js.info.something_went_wrong")}
      end
    end

  end

  private
  
  def send_asset_params
    params.require(:asset).permit(:address, :amount)
  end

  def asset_params
    params.require(:asset).permit(:wif_id, :name, :amount, :fee, :issuer, :description, :picture, :company_name, :address, :profit_margin)
  end
end
