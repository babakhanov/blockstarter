class AddTxHexToAsset < ActiveRecord::Migration
  def change
    add_column :assets, :tx_hex, :text
  end
end
