require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    context '新規登録できるとき' do
      it 'すべての項目が正しく入力されていれば保存できること' do
        expect(@user).to be_valid
      end
    end

    context '新規登録できないとき' do
      it 'nicknameが空では保存できできないこと' do
        @user.nickname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include('ニックネームを入力してください')
      end

      it 'emailが空では保存できないこと' do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include('Eメールを入力してください')
      end

      it '重複したemailが存在する場合登録できないこと' do
        @user.save
        another_user = FactoryBot.build(:user, email: @user.email)
        another_user.valid?
        expect(another_user.errors.full_messages).to include('Eメールはすでに存在します')
      end

      it 'メールアドレスに@を含まない場合は登録できない' do
        @user.email = 'text.example'
        @user.valid?
        expect(@user.errors.full_messages).to include('Eメールは不正な値です')
      end

      it 'passwordが空では保存できないこと' do
        @user.password = ''
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワードを入力してください')
      end

      it 'passwordとpassword_confirmationが不一致では保存ができないこと' do
        @user.password = 'look1234'
        @user.password_confirmation = 'look4321'
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワード（確認用）とパスワードの入力が一致しません')
      end

      it 'passwordが5文字以下では保存ができないこと' do
        @user.password = 'look1'
        @user.password_confirmation = 'look1'
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワードは6文字以上で入力してください')
      end

      it 'passwordが半角英数字入力でなければ登録できないこと' do
        @user.password = 'looklook'
        @user.password_confirmation = 'looklook'
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワードは半角英数字で入力してください')
      end

      it 'passwordが数字のみでは登録できないこと' do
        @user.password = '1234567'
        @user.password_confirmation = '1234567'
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワードは半角英数字で入力してください')
      end

      it 'passwordが全角文字を含んでる場合は登録できないこと' do
        @user.password = 'ロック1234'
        @user.password_confirmation = 'ロック1234'
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワードは半角英数字で入力してください')
      end

      it 'first_nameが空では登録ができないこと' do
        @user.first_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include('お名前を入力してください')
      end

      it 'first_nameが全角入力でなければ登録ができないこと' do
        @user.first_name = 'gorou'
        @user.valid?
        expect(@user.errors.full_messages).to include('お名前は全角(漢字・ひらがな・カタカナ)で入力してください')
      end

      it 'last_nameが空では登録ができないこと' do
        @user.last_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include('名字を入力してください')
      end

      it 'last_nameが全角入力でなければ登録ができないこと' do
        @user.last_name = 'Tanaka'
        @user.valid?
        expect(@user.errors.full_messages).to include('名字は全角(漢字・ひらがな・カタカナ)で入力してください')
      end

      it 'first_name_kanaが空では登録ができないこと' do
        @user.first_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include('お名前カナを入力してください')
      end

      it 'first_name_kanaが全角カタカナでなければ登録できないこと' do
        @user.first_name_kana = 'ごろう'
        @user.valid?
        expect(@user.errors.full_messages).to include('お名前カナは全角(カタカナ)で入力してください')
      end

      it 'last_name_kanaが空では登録ができないこと' do
        @user.last_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include('名字カナを入力してください')
      end

      it 'last_name_kanaが全角カタカナでなければ登録できないこと' do
        @user.last_name_kana = 'たなか'
        @user.valid?
        expect(@user.errors.full_messages).to include('名字カナは全角(カタカナ)で入力してください')
      end

      it 'birth_dateが空では登録ができないこと' do
        @user.birth_date = ''
        @user.valid?
        expect(@user.errors.full_messages).to include('生年月日を入力してください')
      end
    end
  end
end
