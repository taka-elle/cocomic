class ShopItemsController < ApplicationController
  before_action :authenticate_user!,only: [:search]
  before_action :authenticate_shop!,only: [:new,:create,:destroy]


  def search
    @search_shops = SearchItemService.search(params[:isbn],params[:area_id])
  end
  
  def new
    if params[:keyword] != ""
      @books = RakutenWebService::Books::Book.search(title: params[:keyword])
    else
      redirect_to new_shop_item_path
      flash[:shop_item] = "タイトルを入力してください"
    end
    @shop_item = ShopItem.new
    items_isbn = ShopItem.where(shop_id: current_shop.id).order('created_at DESC')
    @shop_items = SearchItemService.make_items(items_isbn)
  end

  def create
    @shop_item = ShopItem.new(shop_item_params)
    if @shop_item.save
      redirect_to new_shop_item_path
      flash[:shop_item] = "登録しました"
    else
      redirect_to new_shop_item_path
      flash[:shop_item] = "すでに登録済みです"
    end
  end

  def destroy
    shop_item = ShopItem.find(params[:id])
    shop_item.destroy
    redirect_to new_shop_item_path
    flash[:shop_item] = "登録を解除しました"
  end

  private

  def shop_item_params
    params.require(:shop_item).permit(:isbn).merge(shop_id: current_shop.id)
  end
end
