class AddIsbnToShopItems < ActiveRecord::Migration[6.0]
  def change
    add_column :shop_items, :isbn, :string
    remove_column :shop_items, :title, :string
    remove_column :shop_items, :num, :string
  end
end
