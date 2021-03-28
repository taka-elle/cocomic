class ShopDataController < ApplicationController
  def new
    @shop_data = ShopDatum.new
  end
  
  def create
    shop_data = ShopDatum.new(shop_data_params)
    if shop_data.save
      redirect_to shop_path(current_shop.id)
    else
      render :new
    end
  end

  private

  def shop_data_params
    params.require(:shop_datum).permit(:text,images: []).merge(shop_id: current_shop.id)
  end
end
