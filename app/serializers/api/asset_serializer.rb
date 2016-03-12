class Api::AssetSerializer < ::ApiSerializer  
  attributes :id, :state, :name, :issuer, :picture_url, :description, :picture, :company_name, :profit_margin, :amount, :is_issued, :tx_ids
  def state
    if !object.is_issued 
      :not_issued
    else
      :active
    end
  end
  
  def picture_url
    object.picture.normal.url if object.picture
  end
end
