require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    context '新規登録できるとき' do
      it '全て入力されていれば登録できる' do
        expect(@user).to be_valid
      end
      it 'emailに＠が含まれていれば登録できる' do
        @user.email = 'aaa@aaa'
        expect(@user).to be_valid
      end
      it 'passowrdとpassword_confirmationが６文字以上であれば登録できる' do
        @user.password = 'a12345'
        @user.password_confirmation = 'a12345'
        expect(@user).to be_valid
      end
      it 'passwordとpassword_confirmationが半角英数字混合していれば登録できる' do
        @user.password = 'a12345'
        @user.password_confirmation = 'a12345'
        expect(@user).to be_valid
      end
    end

    context '新規登録できないとき' do
      it 'nameが空では登録されない' do
        @user.name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "ニックネームを入力してください"
      end
      it 'emailが空では登録されない' do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "メールアドレスを入力してください"
      end
      it '既に登録されているemailでは登録されない' do
        @user.save
        another_user = FactoryBot.build(:user, email: @user.email)
        another_user.valid?
        expect(another_user.errors.full_messages).to include "メールアドレスはすでに存在します"
      end
      it '＠を含んでいないemailは登録されない' do
        @user.email = 'testcom'
        @user.valid?
        expect(@user.errors.full_messages).to include "メールアドレスは不正な値です"
      end
      it 'passwordが空では登録されない' do
        @user.password = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "パスワードを入力してください"
      end
      it 'passwordが存在してもpassword_confirmationが空では登録されない' do
        @user.password_confirmation = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "パスワード(確認用)とパスワードの入力が一致しません"
      end
      it 'passwordは５文字以下では登録されない' do
        @user.password = 'a1234'
        @user.valid?
        expect(@user.errors.full_messages).to include "パスワードは6文字以上で入力してください"
      end
      it 'passwordとpassword_confirmationが異なる場合は登録されない' do
        @user.password = 'a00000'
        @user.password_confirmation = 'a11111'
        @user.valid?
        expect(@user.errors.full_messages).to include "パスワード(確認用)とパスワードの入力が一致しません"
      end
      it 'passwordとpassword_confirmationが半角数字だけでは登録されない' do
        @user.password = '123456'
        @user.password_confirmation = '123456'
        @user.valid?
        expect(@user.errors.full_messages).to include "パスワードは不正な値です"
      end
      it 'passwordとpassword_confirmationが半角英字だけでは登録されない' do
        @user.password = 'abcdef'
        @user.password_confirmation = 'abcdef'
        @user.valid?
        expect(@user.errors.full_messages).to include "パスワードは不正な値です"
      end
    end
  end
end