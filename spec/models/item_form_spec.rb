require 'rails_helper'

RSpec.describe ItemForm, type: :model do
  describe '出品情報の登録' do
    before do
      @user = FactoryBot.create(:user)
      @item_form = FactoryBot.build(:item_form, user_id: @user.id)
      @item_form.images = fixture_file_upload("/files/test_image.png")
    end

    context '内容に問題がない場合' do
      it 'すべての値が正しく入力されていれば保存できること' do
        expect(@item_form).to be_valid
      end
    end
    
    context '内容に問題がある場合' do
      it 'nameが空では登録できないこと' do
        @item_form.name = ''
        @item_form.valid?
        expect(@item_form.errors.full_messages).to include('商品名を入力してください')
      end
      
      it 'infoが空では登録できないこと' do
        @item_form.info = ''
        @item_form.valid?
        expect(@item_form.errors.full_messages).to include('商品の説明を入力してください')
      end
      
      it 'imagesが空では登録できないこと' do
        @item_form.images = nil
        @item_form.valid?
        expect(@item_form.errors.full_messages).to include('画像を入力してください')
      end
      
      it 'categoryが空では登録できないこと' do
        @item_form.category_id = nil
        @item_form.valid?
        expect(@item_form.errors.full_messages).to include('カテゴリーを選択してください')
      end
      
      it 'conditionが空では登録できないこと' do
        @item_form.condition_id = nil
        @item_form.valid?
        expect(@item_form.errors.full_messages).to include('商品の状態を選択してください')
      end
      
      it 'delivery_feeが空では登録できないこと' do
        @item_form.delivery_fee_id = '1'
        @item_form.valid?
        expect(@item_form.errors.full_messages).to include('配送料の負担を選択してください')
      end
      
      it 'prefectureが空では登録できないこと' do
        @item_form.prefecture_id = '1'
        @item_form.valid?
        expect(@item_form.errors.full_messages).to include('発送元の地域を選択してください')
      end
      
      it 'scheduled_deliveryが空では登録できないこと' do
        @item_form.scheduled_delivery_id = '1'
        @item_form.valid?
        expect(@item_form.errors.full_messages).to include('発送までの日数を選択してください')
      end
      
      it 'priceが空では登録できないこと' do
        @item_form.price = nil
        @item_form.valid?
        expect(@item_form.errors.full_messages).to include('販売価格を入力してください')
      end
      
      it 'priceが半角数値でなければ登録できないこと' do
        @item_form.price = '１００００'
        @item_form.valid?
        expect(@item_form.errors.full_messages).to include('販売価格は半角数値で入力してください')
      end
      
      it 'priceが¥300未満では登録できないこと' do
        @item_form.price = '100'
        @item_form.valid?
        expect(@item_form.errors.full_messages).to include('販売価格は¥300~¥9,999,999の範囲内で入力してください')
      end

      it 'priceが¥9_999_999を超えると登録できないこと' do
        @item_form.price = '10000000'
        @item_form.valid?
        expect(@item_form.errors.full_messages).to include('販売価格は¥300~¥9,999,999の範囲内で入力してください')
      end

      it 'userが紐付いていなければ登録できないこと' do
        @item_form.user_id = nil
        @item_form.valid?
        expect(@item_form.errors.full_messages).to include('Userを入力してください')
      end
    end
  end
end
