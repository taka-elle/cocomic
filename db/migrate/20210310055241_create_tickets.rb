class CreateTickets < ActiveRecord::Migration[6.0]
  def change
    create_table :tickets do |t|
      t.date :get_day,            null: false
      t.integer :having_day,      null: false
      t.string :isbn,             null: false
      t.references :user,         null: false, foreign_key: true
      t.references :shop_item,    null: false, foreign_key: true

      t.timestamps
    end
  end
end
