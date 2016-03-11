class Api::AssetSerializer < ActiveModel::Serializer  
  attributes :id, :name, :issuer, :description, :picture, :company_name, :profit_margin, :amount, :tx_id, :is_issued
end
