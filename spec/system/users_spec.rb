require 'rails_helper'

RSpec.describe 'ユーザー新規登録', type: :system do
  before do
    @user = FactoryBot.build(:user)
    @shop = FactoryBot.create(:shop)
    @shop_data = FactoryBot.create(:shop_datum, shop: @shop)
    sleep(0.1)
  end
  context 'ユーザー新規登録ができるとき' do 
    it '正しい情報を入力すればユーザー新規登録ができてトップページに移動する' do
      # トップページから新規ページへ移動
      visit root_path
      expect(
          find(".load-modal-close").click)
      expect(page).to have_content("新規登録")
      visit new_user_registration_path

      # ユーザー情報を入力し、モデルのカウントが増えることを確認
      fill_in 'ニックネーム', with: @user.name
      fill_in 'メールアドレス', with: @user.email
      fill_in 'パスワード', with: @user.password
      fill_in 'パスワード(確認用)', with: @user.password_confirmation
      expect{
        find('input[name="commit"]').click
      }.to change {User.count}.by(1)
        expect(current_path).to eq items_path

      # ログアウトボタンを確認
      expect(
          find(".login-name").click
        )
      expect(page).to have_content('ログアウト')
    end
  end
  context 'ユーザー新規登録ができないとき' do
    it '誤った情報ではユーザー新規登録ができずに新規登録ページへ戻ってくる' do
      # トップページから新規登録ページへ移動
      visit root_path
      expect(
          find(".load-modal-close").click)
      expect(page).to have_content('新規登録')
      visit new_user_registration_path

      # 入力欄を空で登録してもモデルのカウントが上がらないことを確認
      fill_in 'ニックネーム',with:""
      fill_in 'メールアドレス',with:""
      fill_in 'パスワード',with:""
      fill_in 'パスワード(確認用)',with:""
      expect{
        find('input[name="commit"]').click
      }.to change {User.count}.by(0)
      expect(current_path).to eq "/users"
    end
    it 'Shopで既にログインしているとき、メニューとトップ画像内の新規登録ボタンがなくなっている'do
    #トップページへ移動し、「新規登録」ボタンがなくなっているのを確認する
    sign_in_shop(@shop)
      visit root_path
      expect(find(".load-modal-close").click)
      expect(page).to have_no_content('新規登録')
    end
    it 'Shopで既にログインしているとき、トップ画面の「はじめる」ボタンをおしてもトップ画面へ遷移される'do
      #トップページへ移動し、「はじめる」ボタンがあるのを確認する
      sign_in_shop(@shop)
      visit root_path
      expect(find(".load-modal-close").click)
      expect(page).to have_content('はじめる')
      
      #トップページの「はじめる」ボタンをclickしてもトップページへ遷移される
      find('.signup-link').click
      expect(current_path).to eq root_path
    end
  end
end

RSpec.describe 'ログイン', type: :system do
  before do
    @user = FactoryBot.create(:user)
    @shop = FactoryBot.create(:shop)
    @shop_data = FactoryBot.create(:shop_datum, shop: @shop)
  end
  context 'ログインができるとき' do
    it '保存されているユーザーの情報と合致すればログインができる' do
      # トップページからログインページへ移動する
      visit root_path
      expect(
          find(".load-modal-close").click)
      expect(page).to have_content('ログイン')
      visit new_user_session_path

      # 正しいユーザー情報を入力するしログイン
      fill_in 'メールアドレス',with:@user.email
      fill_in 'パスワード',with:@user.password
      find('input[name="commit"]').click
      expect(current_path).to eq items_path

      # ログアウトボタンを確認
      expect(
          find(".login-name").click
        )
      expect(page).to have_content('ログアウト')
    end
  end
  context 'ログインができないとき' do
    it '保存されているユーザーの情報と合致しないとログインができない' do
      # トップページからログインページへ移動
      visit root_path
      expect(
          find(".load-modal-close").click)
      expect(page).to have_content('ログイン')
      visit new_user_session_path

      # 謝ったユーザー情報を入力してもログインされない
      fill_in 'メールアドレス',with:""
      fill_in 'パスワード',with:""
      find('input[name="commit"]').click
      expect(current_path).to eq new_user_session_path
    end
    it 'Shopで既にログインしているとき、トップページのログインボタンがログアウトボタンに切り替わっている'do
    #トップページへ移動し、「ログイン」ボタンがなくなっているのを確認する
    sign_in_shop(@shop)
      visit root_path
      expect(find(".load-modal-close").click)
      expect(page).to have_no_content('ログイン')
      expect(page).to have_content('ログアウト')
    end
  end
end
