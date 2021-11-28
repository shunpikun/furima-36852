require 'rails_helper'

RSpec.describe OrderAddress, type: :model do
  describe '商品購入情報の保存' do
    before do
      @user = FactoryBot.create(:user)
      @item = FactoryBot.create(:item)
      @order_address = FactoryBot.build(:order_address, user_id: @user.id, item_id: @item.id)
      sleep 0.1
    end

    context '内容に問題がない場合' do
      it 'すべての値が正しく入力されていれば保存できること' do
        expect(@order_address).to be_valid
      end

      it 'building_nameは空でも保存できること' do
        @order_address.building_name = ''
        @order_address.valid?
        expect(@order_address).to be_valid
      end
    end

    context '内容に問題がある場合' do
      it 'postal_codeが空だと保存できないこと' do
        @order_address.postal_code = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("郵便番号を入力してください")
      end

      it 'postal_codeが半角のハイフンを含んだ正しい形式でないと保存できないこと' do
        @order_address.postal_code = '123ー4567'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include('郵便番号は「3桁ハイフン4桁」の半角文字列を入力してください')
      end

      it 'prefecture_idが空だと保存できないこと' do
        @order_address.prefecture_id = '1'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("都道府県を選択してください")
      end

      it 'cityが空では保存できないこと' do
        @order_address.city = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("市区町村を入力してください")
      end

      it 'house_numbreが空では保存できないこと' do
        @order_address.house_number = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("番地を入力してください")
      end

      it 'phone_numberが空では保存できないこと' do
        @order_address.phone_number = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("電話番号を入力してください")
      end

      it 'phone_numberが10桁以上11桁以内でないと保存できないこと' do
        @order_address.phone_number = '123456789'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include('電話番号は10桁以上11桁以内で入力してください')
      end

      it 'phone_numberが半角数値でないと保存できないこと' do
        @order_address.phone_number = '１２３４５６７８９'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include('電話番号は半角数値で入力してください')
      end

      it 'phone_numberが9桁以下だと登録できないこと' do
        @order_address.phone_number = '123456789'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include('電話番号は10桁以上11桁以内で入力してください')
      end

      it 'user_idが空では保存できないこと' do
        @order_address.user_id = nil
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Userを入力してください")
      end

      it 'item_idが空では保存できないこと' do
        @order_address.item_id = nil
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Itemを入力してください")
      end

      it 'tokenが空では保存が出来ないこと' do
        @order_address.token = nil
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("クレジットカード情報を入力してください")
      end
    end
  end
end
