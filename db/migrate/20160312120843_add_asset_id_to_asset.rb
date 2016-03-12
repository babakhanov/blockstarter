class AddAssetIdToAsset < ActiveRecord::Migration
  def change
    add_column :assets, :asset_id, :string
  end
end
