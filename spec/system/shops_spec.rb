require 'rails_helper'

RSpec.describe 'ショップ新規登録', type: :system do
  before do
    @shop = FactoryBot.build(:shop)
    @user = FactoryBot.create(:user)
    sleep(1)
  end
  context 'ショップ新規登録ができるとき' do 
    it '正しい情報を入力すればショップ新規登録ができてトップページに移動する' do
      # トップページに移動する
      visit root_path

      #「閉じる」ボタンでモーダルウィンドウを閉じる
      expect(find(".load-modal-close").click)

      # トップページにショップのサインアップページへ遷移するボタンがあることを確認する
      expect(page).to have_content('ショップ登録はこちら')

      # 新規登録ページへ移動する
      visit new_shop_registration_path

      # ショップ情報を入力する
      fill_in 'ショップ名', with: @shop.name
      fill_in 'メールアドレス', with: @shop.email
      fill_in 'パスワード', with: @shop.password
      fill_in 'パスワード(確認用)', with: @shop.password_confirmation
      fill_in '市区町村',with: @shop.city
      fill_in '番地',with: @shop.add_line
      fill_in '建物',with: @shop.build

      # サインアップボタンを押すとShopモデルのカウントが1上がることを確認する
      expect{
        find('input[name="commit"]').click
      }.to change {Shop.count}.by(1)

      # ページ内にログアウトへ遷移するボタンがあることを確認する
      expect(page).to have_content('ログアウト')
    end
  end

  context 'ショップ新規登録ができないとき' do
    it '誤った情報ではショップ新規登録ができずに新規登録ページへ戻ってくる' do
      # トップページに移動する
      visit root_path

      #「閉じる」ボタンでモーダルウィンドウを閉じる
      expect(find(".load-modal-close").click)

      # トップページにサインアップページへ遷移するボタンがあることを確認する
      expect(page).to have_content('ショップ登録はこちら')

      # 新規登録ページへ移動する
      visit new_shop_registration_path

      # ショップ情報を入力する
      fill_in 'ショップ名',with:""
      fill_in 'メールアドレス',with:""
      fill_in 'パスワード',with:""
      fill_in 'パスワード(確認用)',with:""
      fill_in '市区町村',with: ""
      fill_in '建物',with: ""

      # サインアップボタンを押してもShopモデルのカウントは上がらないことを確認する
      expect{
        find('input[name="commit"]').click
      }.to change {Shop.count}.by(0)
      # 新規登録ページへ戻されることを確認する
      expect(current_path).to eq "/shops"
    end

    it 'Userで既にログインしているときに新規登録ページにいこうとするとトップページへ遷移される'do
      #Userでログイン
      sign_in_user(@user)

      #トップページへ移動し、「ショップ登録はこちら」の文字があるのを確認する
      visit root_path
      expect(find(".load-modal-close").click)
      expect(page).to have_content('ショップ登録はこちら')

      #「ショップ登録はこちら」を押すとトップページへ遷移される
      find('.shop-sign-up').click
      expect(current_path).to eq root_path
    end
  end
end

RSpec.describe 'ログイン', type: :system do
  before do
    @shop = FactoryBot.create(:shop)
  end
  context 'ログインができるとき' do
    it '保存されているショップの情報と合致すればログインができる' do
      # トップページに移動する
      visit root_path

      #「閉じる」ボタンでモーダルウィンドウを閉じる
      expect(find(".load-modal-close").click)

      # トップページにショップのサインアップページへ遷移するボタンがあることを確認する
      expect(page).to have_content('ショップ登録はこちら')

      # ログインページへ遷移する
      visit new_shop_session_path

      # 正しいショップ情報を入力する
      fill_in 'メールアドレス',with:@shop.email
      fill_in 'パスワード',with:@shop.password

      # ログインボタンを押す
      find('input[name="commit"]').click

      # トップページへ遷移することを確認する
      expect(current_path).to eq shop_path(@shop)

      # ページ内にログアウトへ遷移するボタンがあることを確認する
      expect(page).to have_content('ログアウト')
    end
  end
  context 'ログインができないとき' do
    it '保存されているショップの情報と合致しないとログインができない' do
      # トップページに移動する
      visit root_path

      #「閉じる」ボタンでモーダルウィンドウを閉じる
      expect(
          find(".load-modal-close").click)

      # トップページにショップのサインアップページへ遷移するボタンがあることを確認する
      expect(page).to have_content('ショップ登録はこちら')

      # ログインページへ遷移する
      visit new_shop_session_path

      # ショップ情報を入力する
      fill_in 'メールアドレス',with:""
      fill_in 'パスワード',with:""

      # ログインボタンを押す
      find('input[name="commit"]').click

      # ログインページへ戻されることを確認する
      expect(current_path).to eq new_shop_session_path
    end
  end
end

RSpec.describe 'お店の説明文', type: :system do
  before do
    @shop = FactoryBot.create(:shop)
    @shop_text = Faker::Lorem.sentence
    @shop_imege = "app/assets/images/cocomic-shop-demo.jpg"
    sleep(3)
  end
  context 'お店の説明文と画像を登録する'do
    it 'ログインしたショップは説明文と画像を登録できる'do
      # ログインする
      sign_in_shop(@shop)

      # 基本情報編集ページへのリンクがあることを確認する
      expect(page).to have_content('基本情報')

      # 基本情報編集ページへ遷移する
      visit edit_shop_registration_path

      # フォームに情報を入力する
      fill_in 'パスワード',with:@shop.password
      fill_in 'パスワード(確認用)',with:@shop.password
      fill_in '現在のパスワード',with:@shop.password
      fill_in 'お店の説明',with: @shop_text
      attach_file "shop[image]",@shop_imege
      
      #修正ボタンをおす
      find('.signup-submit').click

      #「情報が更新されました」と表示されているページへ遷移される
      expect(page).to have_content('情報が更新されました')

      #shopの詳細ページへいく
      visit shop_path(@shop)

      #詳細ページにTextが表示されていることを確認する
      expect(page).to have_content(@shop_text)

      #詳細ページにImageが表示されていることを確認する
      expect(page).to have_content(@shop_image)
    end
  end
end
