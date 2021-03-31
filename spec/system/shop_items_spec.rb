require 'rails_helper'

RSpec.describe "ShopItems", type: :system do
  before do
    @shop = FactoryBot.create(:shop)
    @shop_data = FactoryBot.create(:shop_datum, shop: @shop)
    @keyword = "onepiece"
    sleep(3)
  end

  context 'shop_itemが登録できる' do
    it 'ログインしたショップが正しく情報を入力するとshop_itemを登録できる'do
    #コミック登録ページへ移動する
      sign_in_shop(@shop)
      expect(page).to have_content('コミック登録')
      visit new_shop_item_path

      #検索欄にタイトルを入力し登録する
      fill_in 'keyword', with: @keyword
      find('#search-title-submit').click
      expect(page).to have_selector ".search-commic-data"
      expect(page).to have_selector "#search-commic-input"
      expect{
        click_on '登録する', match: :first
      }.to change { ShopItem.count }.by(1)
      expect(current_path).to eq new_shop_item_path
    end
  end

  context 'shop_itemが登録できない' do
    it 'keywordが空だと登録ページへリダイレクトされる'do
      # 検索ページまで移動する
      sign_in_shop(@shop)
      expect(page).to have_content('コミック登録')
      visit new_shop_item_path

      # タイトルを空にして検索する
      fill_in 'keyword', with: ""
      find('#search-title-submit').click
      expect(current_path).to eq new_shop_item_path
      expect(page).to have_content('タイトルを入力してください')
    end
    it '１つのショップで既に同じitemが登録されているときは登録できない'do
      # ショップでコミックを一つ登録する
      sign_in_shop(@shop)
      expect(page).to have_content('コミック登録')
      visit new_shop_item_path
      fill_in 'keyword', with: @keyword
      find('#search-title-submit').click
      expect(page).to have_selector "#search-commic-input"
      click_on '登録する', match: :first
      expect(current_path).to eq new_shop_item_path

      #同じコミックを登録しようとしてもモデルのカウントが変わらないことを確認する
      fill_in 'keyword', with: @keyword
      find('#search-title-submit').click
      expect(page).to have_selector "#search-commic-input"
      expect{
        click_on '登録する', match: :first
      }.to change { ShopItem.count }.by(0)
      expect(current_path).to eq new_shop_item_path
      expect(page).to have_content('すでに登録済みです')
    end
  end

  context 'shop_itemを削除する'do
    it 'ショップでログインしている状態で「登録を取り消す」ボタンをおすとshop_itemを削除できる'do
      # コミックを登録する
      sign_in_shop(@shop)
      visit new_shop_item_path
      fill_in 'keyword', with: @keyword
      find('#search-title-submit').click
      expect{
        click_on '登録する', match: :first
      }.to change { ShopItem.count }.by(1)
      expect(current_path).to eq new_shop_item_path

      #「登録を取り消す」ボタンを押すとShopItemモデルのカウントが-1になっているのを確認する
      expect(page).to have_content('登録を取り消す')
      expect{
        click_on '登録を取り消す', match: :first
      }.to change { ShopItem.count }.by(-1)
      expect(current_path).to eq new_shop_item_path
      expect(page).to have_content('登録を解除しました')
    end
  end
end
