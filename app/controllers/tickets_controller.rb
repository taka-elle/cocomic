class TicketsController < ApplicationController
  before_action :authenticate_user!,only: [:new,:create,:destroy]
  before_action :authenticate_any!,only: [:edit]

  def new
    @ticket = Ticket.new
    @shop_item = ShopItem.find(params[:shop_item_id])
  end

  def create
    @ticket = Ticket.new(ticket_params)
    @shop_item = ShopItem.find(params[:shop_item_id])
    if @ticket.save
      redirect_to items_path
      flash[:ticket_get] = "チケットを発行しました"
    else
      flash[:ticket_no_get] = "チケットを発行できませんでした"
      render :new
    end
  end

  def edit
    @ticket = Ticket.find(params[:id])
    @return_day = @ticket.get_day + @ticket.having_day - 1
  end

  def destroy
    ticket = Ticket.find(params[:id])
    ticket.destroy
    redirect_to items_path
    flash[:ticket_get] = "チケットを削除しました"
  end

  private
  def ticket_params
    params.require(:ticket).permit(:get_day, :having_day,:isbn).merge(user_id: current_user.id,shop_item_id: params[:shop_item_id].to_i)
  end
end
