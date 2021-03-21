require 'rails_helper'

RSpec.describe 'ユーザー新規登録', type: :system do
  before do
    @user = FactoryBot.build(:user)
    @shop = FactoryBot.create(:shop)
    sleep(0.1)
  end
  context 'ユーザー新規登録ができるとき' do 
    it '正しい情報を入力すればユーザー新規登録ができてトップページに移動する' do
      # トップページに移動する
      visit root_path
      #「閉じる」ボタンでモーダルウィンドウを閉じる
      expect(
          find(".load-modal-close").click)
      # トップページにサインアップページへ遷移するボタンがあることを確認する
      expect(page).to have_content("新規登録")
      # 新規登録ページへ移動する
      visit new_user_registration_path
      # ユーザー情報を入力する
      fill_in 'ニックネーム', with: @user.name
      fill_in 'メールアドレス', with: @user.email
      fill_in 'パスワード', with: @user.password
      fill_in 'パスワード(確認用)', with: @user.password_confirmation
      # サインアップボタンを押すとユーザーモデルのカウントが1上がることを確認する
      expect{
        find('input[name="commit"]').click
      }.to change {User.count}.by(1)
      # itemsトップページへ遷移する
        expect(current_path).to eq items_path
      # ユーザー名をクリックするとメニューが開く
      expect(
          find(".login-name").click
        )
      # メニューにログアウトへ遷移するボタンがあることを確認する
      expect(page).to have_content('ログアウト')
    end
  end
  context 'ユーザー新規登録ができないとき' do
    it '誤った情報ではユーザー新規登録ができずに新規登録ページへ戻ってくる' do
      # トップページに移動する
      visit root_path
      #「閉じる」ボタンでモーダルウィンドウを閉じる
      expect(
          find(".load-modal-close").click)
      # トップページにサインアップページへ遷移するボタンがあることを確認する
      expect(page).to have_content('新規登録')
      # 新規登録ページへ移動する
      visit new_user_registration_path
      # ユーザー情報を入力する
      fill_in 'ニックネーム',with:""
      fill_in 'メールアドレス',with:""
      fill_in 'パスワード',with:""
      fill_in 'パスワード(確認用)',with:""
      # サインアップボタンを押してもユーザーモデルのカウントは上がらないことを確認する
      expect{
        find('input[name="commit"]').click
      }.to change {User.count}.by(0)
      # 新規登録ページへ戻されることを確認する
      expect(current_path).to eq "/users"
    end
    it 'Shopで既にログインしているとき、メニューとトップ画像内の新規登録ボタンがなくなっている'do
      #Shopでログイン
      sign_in_shop(@shop)

      #トップページへ移動し、「新規登録」ボタンがなくなっているのを確認する
      visit root_path
      expect(find(".load-modal-close").click)
      expect(page).to have_no_content('新規登録')
    end
    it 'Shopで既にログインしているとき、トップ画面の「はじめる」ボタンをおしてもトップ画面へ遷移される'do
      #Shopでログイン
      sign_in_shop(@shop)

      #トップページへ移動し、「はじめる」ボタンがあるのを確認する
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
  end
  context 'ログインができるとき' do
    it '保存されているユーザーの情報と合致すればログインができる' do
      # トップページに移動する
      visit root_path
      #「閉じる」ボタンでモーダルウィンドウを閉じる
      expect(
          find(".load-modal-close").click)
      # トップページにログインページへ遷移するボタンがあることを確認する
      expect(page).to have_content('ログイン')
      # ログインページへ遷移する
      visit new_user_session_path
      # 正しいユーザー情報を入力する
      fill_in 'メールアドレス',with:@user.email
      fill_in 'パスワード',with:@user.password
      # ログインボタンを押す
      find('input[name="commit"]').click
      # itemsトップページへ遷移することを確認する
      expect(current_path).to eq items_path
      # ユーザー名をクリックするとメニューが開く
      expect(
          find(".login-name").click
        )
      # メニューにログアウトへ遷移するボタンがあることを確認する
      expect(page).to have_content('ログアウト')
    end
  end
  context 'ログインができないとき' do
    it '保存されているユーザーの情報と合致しないとログインができない' do
      # トップページに移動する
      visit root_path
      #「閉じる」ボタンでモーダルウィンドウを閉じる
      expect(
          find(".load-modal-close").click)
      # トップページにログインページへ遷移するボタンがあることを確認する
      expect(page).to have_content('ログイン')
      # ログインページへ遷移する
      visit new_user_session_path
      # ユーザー情報を入力する
      fill_in 'メールアドレス',with:""
      fill_in 'パスワード',with:""
      # ログインボタンを押す
      find('input[name="commit"]').click
      # ログインページへ戻されることを確認する
      expect(current_path).to eq new_user_session_path
    end
    it 'Shopで既にログインしているとき、トップページのログインボタンがログアウトボタンに切り替わっている'do
      #Shopでログイン
      sign_in_shop(@shop)

      #トップページへ移動し、「ログイン」ボタンがなくなっているのを確認する
      visit root_path
      expect(find(".load-modal-close").click)
      expect(page).to have_no_content('ログイン')

      #「ログアウト」ボタンが新しく表示されていることを確認する
      expect(page).to have_content('ログアウト')
    end
  end
end
