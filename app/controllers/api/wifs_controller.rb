class Api::WifsController < ApiController
  def index
    @wifs = current_user.wifs
    respond_with @wifs
  end

  def show
    render json: {wif: @wif.wif}
  end
end
