class Api::AssetSerializer < ActiveModel::Serializer  
  attributes :id, :state, :name, :issuer, :picture_url, :description, :picture, :company_name, :profit_margin, :amount, :tx_id, :is_issued
  def state
    if !object.is_issued 
      :not_issued
    elsif !object.tx_id
      :not_broadcasted
    else
      :active
    end
  end
  
  def picture_url
    object.picture.normal.url if object.picture
  end
end
