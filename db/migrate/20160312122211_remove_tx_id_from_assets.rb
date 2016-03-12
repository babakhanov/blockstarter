class RemoveTxIdFromAssets < ActiveRecord::Migration
  def change
    remove_column :assets, :tx_id, :string
  end
end
