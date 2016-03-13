class AddAddressToWif < ActiveRecord::Migration
  def change
    add_column :wifs, :address, :string
  end
end
