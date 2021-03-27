class CreateShopData < ActiveRecord::Migration[6.0]
  def change
    create_table :shop_data do |t|
      t.text :text
      t.references :shop,         null: false, foreign_key: true
      t.timestamps
    end
  end
end
