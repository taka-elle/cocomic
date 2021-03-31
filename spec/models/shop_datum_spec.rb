require 'rails_helper'

RSpec.describe ShopDatum, type: :model do
  before do
    @shop_data = FactoryBot.build(:shop_datum)
  end

  describe 'ショップ詳細情報の登録' do
    context '登録できるとき' do
      it '全て入力すれば登録できる' do
        expect(@shop_data).to be_valid
      end
      it '説明がなくても登録できる' do
        @shop_data.text = ""
        expect(@shop_data).to be_valid
      end
      it '画像がなくても登録できる' do
        @shop_data.image1 = ""
        @shop_data.image2 = ""
        @shop_data.image3 = ""
        @shop_data.image4 = ""
        @shop_data.image5 = ""
        expect(@shop_data).to be_valid
      end
    end

    context '登録できないとき'do
      it 'ショップと紐づいていなければ登録できない'do
      @shop_data.shop = nil
      @shop_data.valid?
      expect(@shop_data.errors.full_messages).to include "Shopを入力してください"
      end
    end
  end
end
