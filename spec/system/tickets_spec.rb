require 'rails_helper'

RSpec.describe "Tickets", type: :system do
  before do
    @user = FactoryBot.create(:user)
    @shop = FactoryBot.create(:shop)
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

      #ログインする
      sign_in_user(@user)

      #検索ページにいることを確認する
      expect(current_path).to eq items_path

      #コミックの検索欄があることを確認する
      expect(page).to have_selector '.search-form-content'

      #検索欄にkeywordを入力する
      fill_in 'keyword', with: @keyword

      # 調べるボタンを押す
      find('.search-submit').click

      # 検索したデータが表示されていることを確認する
      expect(page).to have_selector ".search-commic-data"

      # 新しく「調べる」のボタンが表示されていることを確認する
      expect(page).to have_selector ".search-commic-submit"

      #search-commic-submit要素の「調べる」ボタンをクリックする
      find('#search-commic-submit').click

      #検索結果一覧ページに遷移していることを確認する
      expect(current_path).to eq search_shop_items_path

      #検索結果が表示されていることを確認する
      expect(page).to have_selector ".search-shop-container"

      #検索結果を一つクリックする
      page.first(".search-shop-container-test").click

      #クリックしたショップの詳細ページへ遷移する
      expect(current_path).to eq shop_path(@shop)
      
      #詳細ページに「予約する」のボタンがあることを確認する
      expect(page).to have_content('予約する')
      
      #「予約する」をクリックする
      page.first("#ticket-get-btn").click
      
      #チケット発行ページに遷移する
      expect(current_path).to eq new_shop_item_ticket_path(@shop_item[:id])

      #ショップの名前が表示されていることを確認する
      expect(page).to have_content(@shop_item.shop.name)

      #取りにくる日と期間を入力する
      select Time.now.year,from: 'ticket_get_day_1i'
      select Time.now.month,from: 'ticket_get_day_2i'
      select Time.now.day,from: 'ticket_get_day_3i'
      fill_in 'having-day', with: @ticket.having_day

      #「予約する」を押すとTicketモデルが一つ増える
      expect{
        find('.reservation-btn').click
      }.to change { Ticket.count }.by(1)

      #検索ページにいることを確認する
      expect(current_path).to eq items_path

      #「チケットを発行しました」と言う文字があるか確認する
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

      #ログインする
      sign_in_user(@user)

      #@keywordでチケットを発行する
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

      #検索ページにいることを確認する
      expect(current_path).to eq items_path

      #もう一度同じshop_itemのticketを発行する
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

      #「このチケットは発行できません」と言う文字があるか確認する
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

      #チケットを発行する
      @ticket.user = @user
      @ticket.shop_item = @shop_item
      @ticket.save

      #ログインする
      sign_in_user(@user)

      #検索ページにチケットが表示されていることを確認する
      expect(page).to have_selector(".ticket")

      #チケットの「表示する」を一枚クリックする
      page.first(".ticket-show-link").click

      #チケット詳細ページへ遷移していることを確認する
      expect(current_path).to eq edit_shop_item_ticket_path(shop_item_id:@ticket.shop_item,id:@ticket)

      #詳細ページにお店の名前、取りにくる日、期間、がそれぞれ表示されていることを確認する
      expect(page).to have_content(@ticket.shop_item.shop.name)
      expect(page).to have_content(@ticket.get_day.strftime("%Y年 %m月 %d日"))
      expect(page).to have_content(@ticket.having_day)

      #「削除」ボタンがあることを確認する
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

      #ユーザーでログインする
      sign_in_user(@user)

      #@keywordでチケットを発行する
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

      #ユーザーをログアウトする
      find('.login-name').click
      find('#user-logout').click

      #ショップをログインする
      sign_in_shop(@shop)

      #ショップ詳細ページでチケットが発行されているのを確認する
      expect(page).to have_selector(".shop-ticket")

      #shop_itemのチケット日付をクリックするとチケットの詳細がでてくる
      page.first(".shop-ticket").click

      #チケット詳細ページにいることを確認する
      expect(current_path).to eq edit_shop_item_ticket_path(shop_item_id:@shop_item,id:@shop_item.ticket.id)
    end
  end
end
