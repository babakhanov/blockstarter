class Api::WifsController < ApiController
  def index
    @wifs = current_user.wifs
    respond_with @wifs
  end

  def show
    render json: {wif: @wif.wif}
  end

  def destroy
    if @wif.delete
      render json: {id: params[:id]}
    end
  end


  def create
    if Wif.find_by(user_id: cur_user.id, address: $api.get_address(params[:wif][:wif]))
      render json: {error: I18n.t("js.wallets.wallet_exists")}
      return
    end
    @wif = current_user.wifs.new params.require(:wif).permit(:wif)
    @wif.address = Bitcoin::Key.from_base58(@wif.wif).addr
    @wif.user_id = current_user.id
    if @wif.address && @wif.save
      render json: @wif
    end
  end
end
