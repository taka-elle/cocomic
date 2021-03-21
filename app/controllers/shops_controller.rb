class ShopsController < ApplicationController
  before_action :authenticate_any!,only: [:show]
  before_action :show_index, only: [:show], if: :shop_signed_in?

  def show
    @shop = Shop.find(params[:id])
    @shop_items = SearchItemService.make_items(@shop.shop_items)
  end

private
  def show_index
    @shop = Shop.find(params[:id])
    redirect_to root_path if current_shop.id != @shop.id
  end
end