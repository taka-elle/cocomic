class SearchItemService
  
  def self.search(isbn,area)
    if isbn != ""
      search_shop_items = ShopItem.where(isbn: isbn)
    else
      ShopItem.all
      flash[:no_search] = "近くにはありませんでした"
    end

    ary_shops = []
    search_shop_items.each do |item|
      if item.shop.area_id == area.to_i
        ary_shops << item.shop
      end
    end
    return ary_shops.uniq
  end

  def self.make_items(input_items)
    items_data = []
    input_items.each do |items|
      book_items = RakutenWebService::Books::Book.search(isbn: items.isbn)
      if items.ticket.blank?
        book_items.each do|item|
          items_data << {title: item.title,id: items.id}
        end
      else 
        book_items.each do|item|
          ticket = {get_day: items.ticket.get_day,having_day: items.ticket.having_day,user: items.ticket.user.name, ticket_id: items.ticket.id}
          items_data << {title: item.title,id: items.id,ticket: ticket}
        end
      end
    end
    return items_data
  end
end