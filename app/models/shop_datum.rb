class ShopDatum < ApplicationRecord
  has_many_attached :images
  belongs_to :shop
end
