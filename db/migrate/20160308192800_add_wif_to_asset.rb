class AddWifToAsset < ActiveRecord::Migration
  def change
    add_reference :assets, :wif, index: true, foreign_key: true
  end
end
