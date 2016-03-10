class AddTxIdIsIssuedToAsset < ActiveRecord::Migration
  def change
    add_column :assets, :tx_id, :string
    add_column :assets,  :is_issued, :boolean, null: false, default: false
  end
end
