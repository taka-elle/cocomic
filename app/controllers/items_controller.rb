class ItemsController < ApplicationController
  before_action :authenticate_user!

  def index
    if params[:keyword]
      @area = Area.find(params[:area_id])
      @books = RakutenWebService::Books::Book.search(title: params[:keyword])
    end
    @tickets = Ticket.where(user_id: current_user.id)
  end

end
