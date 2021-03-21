require 'rails_helper'

RSpec.describe ShopItem, type: :model do
  before do
    @shop_item = FactoryBot.build(:shop_item)
  end

  describe '漫画本登録' do
    context '登録できるとき' do
      it 'isbnがあれば登録できる' do
        expect(@shop_item).to be_valid
      end
    end

    context "登録できないとき" do
      it 'isbnがなければ登録できない' do
        @shop_item.isbn = ""
        @shop_item.valid?
        expect(@shop_item.errors.full_messages).to include "本を入力してください"
      end
      it 'isbnが13文字以外であれば登録できない' do
        @shop_item.isbn = 1 * 12
        @shop_item.valid?
        expect(@shop_item.errors.full_messages).to include "本エラー：この本は登録することができません"
      end
      it 'shopと紐づいていなければ登録できない' do
        @shop_item.shop = nil
        @shop_item.valid?
        expect(@shop_item.errors.full_messages).to include "Shopを入力してください"
      end
      it '既にshop_idとisbnの組み合わせがある場合、そのshop_idとisbnの組み合わせは登録できない'do
        @shop_item.save
        another_shop_item = FactoryBot.build(:shop_item)
        another_shop_item.shop = @shop_item.shop
        another_shop_item.isbn = @shop_item.isbn
        another_shop_item.valid?
        expect(another_shop_item.errors.full_messages).to include "本はすでに存在します"
      end
    end
  end
end
