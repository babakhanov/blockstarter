class AddIsPublishedToAsset < ActiveRecord::Migration
  def change
    add_column :assets, :is_published, :boolean, null: false, default: false
  end
end
