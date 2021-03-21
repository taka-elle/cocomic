require 'rails_helper'

RSpec.describe Shop, type: :model do
  before do
    @shop = FactoryBot.build(:shop)
  end

  describe 'ショップ新規登録' do
    context '新規登録できるとき' do
      it '全て入力されていれば登録できる' do
        expect(@shop).to be_valid
      end
      it 'emailに＠が含まれていれば登録できる' do
        @shop.email = 'aaa@aaa'
        expect(@shop).to be_valid
      end
      it 'passowrdとpassword_confirmationが６文字以上であれば登録できる' do
        @shop.password = 'a12345'
        @shop.password_confirmation = 'a12345'
        expect(@shop).to be_valid
      end
      it 'passwordとpassword_confirmationが半角英数字混合していれば登録できる' do
        @shop.password = 'a12345'
        @shop.password_confirmation = 'a12345'
        expect(@shop).to be_valid
      end
      it 'buildが空でも登録できる' do
        @shop.build = ""
        expect(@shop).to be_valid
      end
    end
    
    context '新規登録できないとき' do
      it 'nameが空では登録されない' do
        @shop.name = ''
        @shop.valid?
        expect(@shop.errors.full_messages).to include "ショップ名を入力してください"
      end
      it 'emailが空では登録されない' do
        @shop.email = ''
        @shop.valid?
        expect(@shop.errors.full_messages).to include "メールアドレスを入力してください"
      end
      it '既に登録されているemailでは登録されない' do
        @shop.save
        another_shop = FactoryBot.build(:shop, email: @shop.email)
        another_shop.valid?
        expect(another_shop.errors.full_messages).to include "メールアドレスはすでに存在します"
      end
      it '＠を含んでいないemailは登録されない' do
        @shop.email = 'testcom'
        @shop.valid?
        expect(@shop.errors.full_messages).to include "メールアドレスは不正な値です"
      end
      it 'passwordが空では登録されない' do
        @shop.password = ''
        @shop.valid?
        expect(@shop.errors.full_messages).to include "パスワードを入力してください"
      end
      it 'passwordが存在してもpassword_confirmationが空では登録されない' do
        @shop.password_confirmation = ''
        @shop.valid?
        expect(@shop.errors.full_messages).to include "パスワード(確認用)とパスワードの入力が一致しません"
      end
      it 'passwordは５文字以下では登録されない' do
        @shop.password = 'a1234'
        @shop.valid?
        expect(@shop.errors.full_messages).to include "パスワード(確認用)とパスワードの入力が一致しません"
      end
      it 'passwordとpassword_confirmationが異なる場合は登録されない' do
        @shop.password = 'a00000'
        @shop.password_confirmation = 'a11111'
        @shop.valid?
        expect(@shop.errors.full_messages).to include "パスワード(確認用)とパスワードの入力が一致しません"
      end
      it 'passwordとpassword_confirmationが半角数字だけでは登録されない' do
        @shop.password = '123456'
        @shop.password_confirmation = '123456'
        @shop.valid?
        expect(@shop.errors.full_messages).to include "パスワードは不正な値です"
      end
      it 'passwordとpassword_confirmationが半角英字だけでは登録されない' do
        @shop.password = 'abcdef'
        @shop.password_confirmation = 'abcdef'
        @shop.valid?
        expect(@shop.errors.full_messages).to include "パスワードは不正な値です"
      end
      it 'cityが空では登録されない' do
        @shop.city = ''
        @shop.valid?
        expect(@shop.errors.full_messages).to include "市区町村を入力してください"
      end
      it 'add_lineが空では登録されない' do
        @shop.add_line = ''
        @shop.valid?
        expect(@shop.errors.full_messages).to include "番地を入力してください"
      end
    end
  end
end
