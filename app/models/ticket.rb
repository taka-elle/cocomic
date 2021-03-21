class Ticket < ApplicationRecord
  belongs_to :user
  belongs_to :shop_item

  with_options presence: true do
    validates :get_day
    validates :having_day, numericality: { only_integer: true}
    validates :isbn, length: { is: 13, :message => 'エラー：この本は登録することができません'}, uniqueness: { scope: :shop_item }
  end
end
