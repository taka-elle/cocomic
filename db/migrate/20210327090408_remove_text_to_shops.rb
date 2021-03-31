class RemoveTextToShops < ActiveRecord::Migration[6.0]
  def change
    remove_column :shops, :text, :string
  end
end
