require 'rails_helper'

RSpec.describe 'お店の詳細情報の登録（新規登録時）', type: :system do
  before do
    @shop = FactoryBot.build(:shop)
    @shop_data = FactoryBot.build(:shop_datum)
    sleep(3)
  end
  context 'お店の新規登録時に詳細情報を登録する'do
    it '新規登録時、ショップは説明文と画像を登録できる'do
      # ショップの基本情報まで入力し、「次へ」ボタンを押す
      visit root_path
      expect(find(".load-modal-close").click)
      expect(page).to have_content('ショップ登録はこちら')
      visit new_shop_registration_path
      fill_in 'ショップ名', with: @shop.name
      fill_in 'メールアドレス', with: @shop.email
      fill_in 'パスワード', with: @shop.password
      fill_in 'パスワード(確認用)', with: @shop.password_confirmation
      fill_in '市区町村',with: @shop.city
      fill_in '番地',with: @shop.add_line
      fill_in '建物',with: @shop.build
      expect{
        find('input[name="commit"]').click
      }.to change {Shop.count}.by(1)

      # ショップの詳細情報を入力し、「登録する」を押すとShopDatumモデルのカウントが１上がる
      fill_in 'お店の説明', with: @shop_data.text
      expect{
        find('input[name="commit"]').click
      }.to change {ShopDatum.count}.by(1)
      expect(page).to have_content('ログアウト')
    end
  end
end

RSpec.describe 'お店の詳細情報の編集', type: :system do
  before do
    @shop = FactoryBot.create(:shop)
    @shop_data = FactoryBot.create(:shop_datum, shop: @shop)
    @new_text = Faker::Lorem.paragraph
    sleep(3)
  end
  context 'お店の新規登録時に詳細情報を登録する'do
    it '新規登録時、ショップは説明文と画像を登録できる'do
      # 編集ページで「修正」ボタンを押してもモデルのカウントは変わらないことを確認する
      sign_in_shop(@shop)
      find('.shop-header-edit-test').click
      expect(page).to have_content(@shop_data.text)
      expect{
        find('input[name="commit"]').click
      }.to change {ShopDatum.count}.by(0)
    end
  end
end