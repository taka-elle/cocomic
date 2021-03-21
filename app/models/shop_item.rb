class ShopItem < ApplicationRecord
  belongs_to :shop
  has_one    :ticket

  validates :isbn,presence: true, uniqueness: { scope: :shop }, length: { is: 13, :message => 'エラー：この本は登録することができません'}
end
