require 'rails_helper'

RSpec.describe Ticket, type: :model do
  before do
    @ticket = FactoryBot.build(:ticket)
  end

  describe 'チケット登録' do
    context 'チケット登録できるとき' do
      it '全て入力されていれば登録できる' do
        expect(@ticket).to be_valid
      end
    end

    context 'チケット登録できないとき' do
      it 'get_dayがなければ登録できない' do
        @ticket.get_day = ""
        @ticket.valid?
        expect(@ticket.errors.full_messages).to include "取りに行く日を入力してください"
      end
      it 'having_dayがなければ登録できない' do
        @ticket.having_day = ""
        @ticket.valid?
        expect(@ticket.errors.full_messages).to include "借りる期間を入力してください"
      end
      it 'having_dayがローマ字では登録できない' do
        @ticket.having_day = "a"
        @ticket.valid?
        expect(@ticket.errors.full_messages).to include "借りる期間は数値で入力してください"
      end
      it 'having_dayが日本語では登録できない' do
        @ticket.having_day = "いち"
        @ticket.valid?
        expect(@ticket.errors.full_messages).to include "借りる期間は数値で入力してください"
      end
      it 'isbnがなければ登録できない' do
        @ticket.isbn = ""
        @ticket.valid?
        expect(@ticket.errors.full_messages).to include "本を入力してください"
      end
      it 'isbnが13文字でなければ登録できない' do
        @ticket.isbn = 1 * 12
        @ticket.valid?
        expect(@ticket.errors.full_messages).to include "本エラー：この本は登録することができません"
      end
      it 'userと紐づいていなければ登録できない' do
        @ticket.user = nil
        @ticket.valid?
        expect(@ticket.errors.full_messages).to include "Userを入力してください"
      end
      it 'shop_itemと紐づいていなければ登録できない' do
        @ticket.shop_item = nil
        @ticket.valid?
        expect(@ticket.errors.full_messages).to include "Shop itemを入力してください"
      end
      it '既にshop_itemとisbnが紐づいているデータがあるとき、その同じ紐づいたデータは登録できない' do
        @ticket.save
        another_ticket = FactoryBot.build(:ticket)
        another_ticket.isbn = @ticket.isbn
        another_ticket.shop_item = @ticket.shop_item
        another_ticket.valid?
        expect(another_ticket.errors.full_messages).to include "本はすでに存在します"
      end
    end
  end
end
