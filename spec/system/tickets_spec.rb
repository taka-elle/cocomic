require 'rails_helper'

RSpec.describe "Tickets", type: :system do
  before do
    @user = FactoryBot.create(:user)
    @shop = FactoryBot.create(:shop)
    @shop_data = FactoryBot.create(:shop_datum, shop: @shop)
    @shop_item = FactoryBot.build(:shop_item)
    @ticket = FactoryBot.build(:ticket)
    @keyword = "onepiece 98"
  end
  context 'チケットを発行できるとき'do
    it 'ログインしたユーザーはチケット発行できる'do
      # shop_itemを登録しておく
      @shop.area_id = 1
      @shop.save
      @shop_item.shop = @shop
      @shop_item.save

      #検索ページでkeywordで検索する
      sign_in_user(@user)
      expect(current_path).to eq items_path
      expect(page).to have_selector '.search-form-content'
      fill_in 'keyword', with: @keyword
      find('.search-submit').click
      expect(page).to have_selector ".search-commic-data"
      expect(page).to have_selector ".search-commic-submit"

      #「調べる」ボタンをクリックし、ショップ詳細ページへ移動する
      find('#search-commic-submit').click
      expect(current_path).to eq search_shop_items_path
      expect(page).to have_selector ".search-shop-container"
      page.first(".search-shop-container-test").click
      expect(current_path).to eq shop_path(@shop)
      
      #「予約する」ボタンでチケット発行ページに移動する
      expect(page).to have_content('予約する')
      page.first("#ticket-get-btn").click
      expect(current_path).to eq new_shop_item_ticket_path(@shop_item[:id])
      expect(page).to have_content(@shop_item.shop.name)

      # チケットを発行する
      select Time.now.year,from: 'ticket_get_day_1i'
      select Time.now.month,from: 'ticket_get_day_2i'
      select Time.now.day,from: 'ticket_get_day_3i'
      fill_in 'having-day', with: @ticket.having_day
      expect{
        find('.reservation-btn').click
      }.to change { Ticket.count }.by(1)
      expect(current_path).to eq items_path
      expect(page).to have_content("チケットを発行しました")
    end
  end

  context 'チケットを発行できないとき' do
    it '既にshop_itemとticketが紐づいてるデータが存在する場合登録できない'do
      # shop_itemを登録しておく
      @shop.area_id = 1
      @shop.save
      @shop_item.shop = @shop
      @shop_item.save

      #チケットを発行する
      sign_in_user(@user)
      fill_in 'keyword', with: @keyword
      find('.search-submit').click
      find('#search-commic-submit').click
      page.first(".search-shop-container-test").click
      page.first("#ticket-get-btn").click
      select Time.now.year,from: 'ticket_get_day_1i'
      select Time.now.month,from: 'ticket_get_day_2i'
      select Time.now.day,from: 'ticket_get_day_3i'
      fill_in 'having-day', with: @ticket.having_day
      expect{
        find('.reservation-btn').click
      }.to change { Ticket.count }.by(1)
      expect(current_path).to eq items_path

      #もう一度同じチケットを発行する
      fill_in 'keyword', with: @keyword
      find('.search-submit').click
      find('#search-commic-submit').click
      page.first(".search-shop-container-test").click
      page.first("#ticket-get-btn").click
      select Time.now.year,from: 'ticket_get_day_1i'
      select Time.now.month,from: 'ticket_get_day_2i'
      select Time.now.day,from: 'ticket_get_day_3i'
      fill_in 'having-day', with: @ticket.having_day

      #予約するを押してもTicketモデルが増えないことを確認する
      expect{
        find('.reservation-btn').click
      }.to change { Ticket.count }.by(0)
      expect(page).to have_content("チケットを発行できませんでした")
    end
  end

  context 'ユーザーがチケットを削除できるとき'do
    it 'ログインしたユーザーはユーザーと紐づいたチケットを削除できる'do
      # shop_itemを登録しておく
      @shop.area_id = 1
      @shop.save
      @shop_item.shop = @shop
      @shop_item.save

      #チケットを発行し、チケットの詳細ページへ移動する
      @ticket.user = @user
      @ticket.shop_item = @shop_item
      @ticket.save
      sign_in_user(@user)
      expect(page).to have_selector(".ticket")
      page.first(".ticket-show-link").click
      expect(current_path).to eq edit_shop_item_ticket_path(shop_item_id:@ticket.shop_item,id:@ticket)
      expect(page).to have_content(@ticket.shop_item.shop.name)
      expect(page).to have_content(@ticket.get_day.strftime("%Y年 %m月 %d日"))
      expect(page).to have_content(@ticket.having_day)
      expect(page).to have_link("削除")

      #「削除」ボタンを押すとTicketモデルのカウントが１減る
      expect{
        find('.load-modal-close').click
      }.to change { Ticket.count }.by(-1)
    end
  end

  context 'ショップがチケットを確認できるとき' do
    it 'ショップに紐づくショップアイテムにチケットがあれば確認できる'do
      # shop_itemを登録しておく
      @shop.area_id = 1
      @shop.save
      @shop_item.shop = @shop
      @shop_item.save

      # チケットを発行し、ログアウト
      sign_in_user(@user)
      fill_in 'keyword', with: @keyword
      find('.search-submit').click
      find('#search-commic-submit').click
      page.first(".search-shop-container-test").click
      page.first("#ticket-get-btn").click
      select Time.now.year,from: 'ticket_get_day_1i'
      select Time.now.month,from: 'ticket_get_day_2i'
      select Time.now.day,from: 'ticket_get_day_3i'
      fill_in 'having-day', with: @ticket.having_day
      find('.reservation-btn').click
      find('.login-name').click
      find('#user-logout').click

      #ショップ側でチケットを確認する
      sign_in_shop(@shop)
      expect(page).to have_selector(".shop-ticket")
      page.first(".shop-ticket").click
      expect(current_path).to eq edit_shop_item_ticket_path(shop_item_id:@shop_item,id:@shop_item.ticket.id)
    end
  end
end
