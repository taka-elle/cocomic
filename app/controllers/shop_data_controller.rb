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

  def edit
    shop = Shop.find(current_shop.id)
    @shop_data = shop.shop_datum
  end

  def update
    shop = Shop.find(current_shop.id)
    @shop_data = shop.shop_datum
    if @shop_data.update(shop_data_params)
      redirect_to edit_shop_datum_path(current_shop.id)
    else
      render :edit
    end
  end

  private

  def shop_data_params
    params.require(:shop_datum).permit(:text,:image1,:image2,:image3,:image4,:image5).merge(shop_id: current_shop.id)
  end
end
