require 'rails_helper'

RSpec.describe "ShopItems", type: :system do
  before do
    @shop = FactoryBot.create(:shop)
    @keyword = "onepiece"
    sleep(3)
  end

  context 'shop_itemが登録できる' do
    it 'ログインしたショップが正しく情報を入力するとshop_itemを登録できる'do
      # ログインする
      sign_in_shop(@shop)

      # コミック登録ボタンがあることを確認する
      expect(page).to have_content('コミック登録')

      #コミック登録ページへ移動する
      visit new_shop_item_path

      #検索欄にタイトルを入力する
      fill_in 'keyword', with: @keyword

      # 検索ボタンを押す
      find('#search-title-submit').click

      # 検索したデータが表示されていることを確認する
      expect(page).to have_selector ".search-commic-data"

      # 「登録する」のボタンが表示されていることを確認する
      expect(page).to have_selector "#search-commic-input"

      #登録するのボタンを押すとShopitemモデルのカウントが1上がることを確認する
      expect{
        click_on '登録する', match: :first
      }.to change { ShopItem.count }.by(1)

      #登録ページにリダイレクトしていることを確認する
      expect(current_path).to eq new_shop_item_path
    end
  end

  context 'shop_itemが登録できない' do
    it 'keywordが空だと登録ページへリダイレクトされる'do
      # ログインする
      sign_in_shop(@shop)

      # コミック登録ボタンがあることを確認する
      expect(page).to have_content('コミック登録')

      #コミック登録ページへ移動する
      visit new_shop_item_path

      #検索欄にタイトルを入力する
      fill_in 'keyword', with: ""

      # 検索ボタンを押す
      find('#search-title-submit').click

      #登録ページにリダイレクトしていることを確認する
      expect(current_path).to eq new_shop_item_path

      #「タイトルを入力してください」の文字が表示されている
      expect(page).to have_content('タイトルを入力してください')
    end
    it '１つのショップで既に同じitemが登録されているときは登録できない'do
      # ログインする
      sign_in_shop(@shop)

      # コミック登録ボタンがあることを確認する
      expect(page).to have_content('コミック登録')

      #コミック登録ページへ移動する
      visit new_shop_item_path

      #一つ目のitemを登録する
      fill_in 'keyword', with: @keyword
      find('#search-title-submit').click
      expect(page).to have_selector "#search-commic-input"
      click_on '登録する', match: :first

      #登録ページにリダイレクトしていることを確認する
      expect(current_path).to eq new_shop_item_path

      #同じitemを登録する
      fill_in 'keyword', with: @keyword
      find('#search-title-submit').click
      expect(page).to have_selector "#search-commic-input"

      #登録するボタンをおしてもモデルのカウントは変わらないことを確認する
      expect{
        click_on '登録する', match: :first
      }.to change { ShopItem.count }.by(0)

      #登録ページにリダイレクトしていることを確認する
      expect(current_path).to eq new_shop_item_path

      #「すでに登録済みです」の文字が表示されている
      expect(page).to have_content('すでに登録済みです')
    end
  end

  context 'shop_itemを削除する'do
    it 'ショップでログインしている状態で「登録を取り消す」ボタンをおすとshop_itemを削除できる'do
      #ログインする
      sign_in_shop(@shop)

      # コミックを登録する
      visit new_shop_item_path
      fill_in 'keyword', with: @keyword
      find('#search-title-submit').click
      
      #登録するのボタンを押すとShopitemモデルのカウントが1上がることを確認する
      expect{
        click_on '登録する', match: :first
      }.to change { ShopItem.count }.by(1)

      #コミック登録ページにいることを確認する
      expect(current_path).to eq new_shop_item_path

      #「登録を取り消す」ボタンがあることを確認する
      expect(page).to have_content('登録を取り消す')

      #「登録を取り消す」を押すとShopitemモデルのカウントが1下がることを確認する
      expect{
        click_on '登録を取り消す', match: :first
      }.to change { ShopItem.count }.by(-1)

      #登録ページにリダイレクトしていることを確認する
      expect(current_path).to eq new_shop_item_path

      #「登録を解除しました」の文字が表示されている
      expect(page).to have_content('登録を解除しました')
    end
  end
end
