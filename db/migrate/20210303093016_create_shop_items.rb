class CreateShopItems < ActiveRecord::Migration[6.0]
  def change
    create_table :shop_items do |t|
      t.text :title
      t.text :num
      t.references :shop,    null: false, foreign_key: true
      t.timestamps
    end
  end
end
