class AddFeeToAsset < ActiveRecord::Migration
  def change
    add_column :assets, :fee, :integer
  end
end
