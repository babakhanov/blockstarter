class RenameSaleMarginToProfitMargin < ActiveRecord::Migration
  def self.up
    rename_column :assets, :sale_margin, :profit_margin
  end

  def self.down
    rename_column :assets, :profit_margin, :sale_margin
  end
end
