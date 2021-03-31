require 'rails_helper'

RSpec.describe 'ショップ新規登録', type: :system do
  before do
    @shop = FactoryBot.build(:shop)
    @shop_data = FactoryBot.create(:shop_datum)
    @user = FactoryBot.create(:user)
    sleep(1)
  end
  context 'ショップ新規登録ができるとき' do 
    it '正しい情報を入力すればショップ新規登録ができてトップページに移動する' do
      # トップページから新規登録ページへ移動する
      visit root_path
      expect(find(".load-modal-close").click)
      expect(page).to have_content('ショップ登録はこちら')
      visit new_shop_registration_path

      # ショップ情報を入力しモデルのカウントが上がっていることを確認
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
      find('.new-shop-submit').click

      # ページ内にログアウトへ遷移するボタンがあることを確認する
      expect(page).to have_content('ログアウト')
    end
  end

  context 'ショップ新規登録ができないとき' do
    it '誤った情報ではショップ新規登録ができずに新規登録ページへ戻ってくる' do
      # トップページから新規登録ページへ移動
      visit root_path
      expect(find(".load-modal-close").click)
      expect(page).to have_content('ショップ登録はこちら')
      visit new_shop_registration_path

      # 入力欄を空にするとカウントが増えないことを確認する
      fill_in 'ショップ名',with:""
      fill_in 'メールアドレス',with:""
      fill_in 'パスワード',with:""
      fill_in 'パスワード(確認用)',with:""
      fill_in '市区町村',with: ""
      fill_in '建物',with: ""
      expect{
        find('input[name="commit"]').click
      }.to change {Shop.count}.by(0)
      expect(current_path).to eq "/shops"
    end

    it 'Userで既にログインしているときに新規登録ページにいこうとするとトップページへ遷移される'do
      #「ショップ登録はこちら」を押すとトップページへ遷移される
      sign_in_user(@user)
      visit root_path
      expect(find(".load-modal-close").click)
      expect(page).to have_content('ショップ登録はこちら')
      find('.shop-sign-up').click
      expect(current_path).to eq root_path
    end
  end
end

RSpec.describe 'ログイン', type: :system do
  before do
    @shop = FactoryBot.create(:shop)
    @shop_data = FactoryBot.create(:shop_datum, shop: @shop)
  end
  context 'ログインができるとき' do
    it '保存されているショップの情報と合致すればログインができる' do
      # トップページからログインページへ移動する
      visit root_path
      expect(find(".load-modal-close").click)
      expect(page).to have_content('ショップ登録はこちら')
      visit new_shop_session_path

      # 正しいショップ情報を入力するとログインできることを確認
      fill_in 'メールアドレス',with:@shop.email
      fill_in 'パスワード',with:@shop.password
      find('input[name="commit"]').click
      expect(current_path).to eq shop_path(@shop)

      # ページ内にログアウトへ遷移するボタンがあることを確認する
      expect(page).to have_content('ログアウト')
    end
  end
  context 'ログインができないとき' do
    it '保存されているショップの情報と合致しないとログインができない' do
      # トップページからログインページへ移動
      visit root_path
      expect(
          find(".load-modal-close").click)
      expect(page).to have_content('ショップ登録はこちら')
      visit new_shop_session_path

      # 誤った情報を入力してもログインできないことを確認
      fill_in 'メールアドレス',with:""
      fill_in 'パスワード',with:""
      find('input[name="commit"]').click
      expect(current_path).to eq new_shop_session_path
    end
  end
end