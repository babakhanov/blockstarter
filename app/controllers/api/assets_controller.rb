class Api::AssetsController < ApiController
  def index
    @assets = cur_user.assets.order(created_at: :desc)
    respond_with @assets
  end

  def show
    respond_with @asset
  end

  def create
    @asset = current_user.assets.new asset_params
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

  def issue
    @asset = Asset.find(params[:asset_id])
    data = @asset.issue
    unless data[:error]
      @asset.broadcast
      respond_with @asset 
    else
      respond_with data
    end
  end

  private

  def asset_params
    params.require(:asset).permit(:wif_id, :name, :amount, :fee, :issuer, :description, :picture, :company_name, :address, :profit_margin)
  end
end
