class Api::AssetsController < ApiController
  def index
    @assets = @assets.order(created_at: :desc)
    respond_with @assets
  end

  def show
    respond_with @asset
  end

  def create
    @asset = Asset.new asset_params
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

  private

  def asset_params
    params.require(:asset).permit(:name, :amount, :fee, :issuer, :description, :picture, :company_name, :address, :profit_margin)
  end
end
