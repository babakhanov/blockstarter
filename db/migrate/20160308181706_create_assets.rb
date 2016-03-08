class CreateAssets < ActiveRecord::Migration
  def change
    create_table :assets do |t|
      t.string :name
      t.string :issuer
      t.string :description
      t.string :picture
      t.string :company_name
      t.string :address
      t.decimal :sale_margin

      t.timestamps null: false
    end
  end
end
