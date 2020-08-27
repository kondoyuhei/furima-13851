require 'rails_helper'

RSpec.describe User, type: :model do
  describe '#create' do
    before do
      @user = FactoryBot.build(:user)
    end

    it "「ニックネーム」「姓」「名」「姓読み」「名読み」「メール」「パスワード」「生年月日」が存在すれば登録できる" do
      expect(@user).to be_valid
    end

    it "「ニックネーム」が空では登録できない" do
      @user.nickname = nil
      @user.valid?
      expect(@user.errors.full_messages).to include("Nickname can't be blank")
    end

    it "「メール」が空では登録できない" do
      @user.email = nil
      @user.valid?
      expect(@user.errors.full_messages).to include("Email can't be blank")
    end

    it "「パスワード」が空では登録できない" do
      @user.password = nil
      @user.valid?
      expect(@user.errors.full_messages).to include("Password can't be blank")
    end

    it "パスワードが存在しても「パスワード確認」が空では登録できない" do
      @user.password_confirmation = ""
      @user.valid?
      expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end

    it "「姓」が空では登録できない" do
      @user.name_sei = nil
      @user.valid?
      expect(@user.errors.full_messages).to include("Name sei can't be blank")
    end

    it "「名」が空では登録できない" do
      @user.name_mei = nil
      @user.valid?
      expect(@user.errors.full_messages).to include("Name mei can't be blank")
    end

    it "「姓読み」が空では登録できない" do
      @user.yomi_sei = nil
      @user.valid?
      expect(@user.errors.full_messages).to include("Yomi sei can't be blank")
    end

    it "「名読み」が空では登録できない" do
      @user.yomi_mei = nil
      @user.valid?
      expect(@user.errors.full_messages).to include("Yomi mei can't be blank")
    end

    it "「生年月日」が空では登録できない" do
      @user.birthday = nil
      @user.valid?
      expect(@user.errors.full_messages).to include("Birthday can't be blank")
    end

    it "パスワードが「6文字以上」であれば登録できる" do
      @user.password = "abc123"
      @user.password_confirmation = "abc123"
      expect(@user).to be_valid
    end

    it "パスワードが「5文字以下」であれば登録できない" do
      @user.password = "abc12"
      @user.password_confirmation = "abc12"
      @user.valid?
      expect(@user.errors.full_messages).to include("Password is too short (minimum is 6 characters)")
    end

    it "パスワードは「英数字混合」でなければ登録できない" do
      @user.password = "abcdef"
      @user.password_confirmation = "abcdef"
      @user.valid?
      expect(@user.errors.full_messages).to include("Password is invalid.")
    end

    it "重複した「メール」は登録できない" do
      @user.save
      another_user = FactoryBot.build(:user, email: @user.email)
      another_user.valid?
      expect(another_user.errors.full_messages).to include("Email has already been taken")
    end

    it "「@」のないメールは登録できない" do
      @user.email = "abcatdef.com"
      @user.valid?
      expect(@user.errors.full_messages).to include("Email is invalid. Email must include '@'. ")
    end

    it "「姓」は全角で入力しなければならない" do
      @user.name_sei = "Abe"
      @user.valid?
      expect(@user.errors.full_messages).to include("Name sei is invalid. Input full-width characters.")
    end

    it "「名」は全角で入力しなければならない" do
      @user.name_sei = "Maria"
      @user.valid?
      expect(@user.errors.full_messages).to include("Name sei is invalid. Input full-width characters.")
    end

    it "「姓読み」は全角で入力しなければならない" do
      @user.yomi_sei = "ｾｲ"
      @user.valid?
      expect(@user.errors.full_messages).to include("Yomi sei is invalid. Input full-width Katakanas.")
    end

    it "「名読み」は全角で入力しなければならない" do
      @user.yomi_mei = "ﾒｲ"
      @user.valid?
      expect(@user.errors.full_messages).to include("Yomi mei is invalid. Input full-width Katakanas.")
    end


  end
end
