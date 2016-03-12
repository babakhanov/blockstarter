class AddTxIdsToAsset < ActiveRecord::Migration
  def change
    add_column :assets, :tx_ids, :text, array: true, default: []
  end
end
