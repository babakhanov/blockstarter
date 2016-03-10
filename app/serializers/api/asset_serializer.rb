class Api::AssetSerializer < ActiveModel::Serializer  
  attributes :id, :name, :issuer, :description, :picture, :company_name, :sale_margin, :amount, :tx_id, :is_issued
end
