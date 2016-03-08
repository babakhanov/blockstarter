class CreateWifs < ActiveRecord::Migration
  def change
    create_table :wifs do |t|
      t.string :wif
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
