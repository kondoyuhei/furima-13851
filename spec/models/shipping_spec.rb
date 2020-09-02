require 'rails_helper'

RSpec.describe Shipping, type: :model do
  describe '#create' do
    before do
      @shipping = FactoryBot.build(:shipping)
    end

    it "「購入id」「郵便番号」「都道府県」「市区町村」「番地」「電話番号」が存在すれば登録できる" do
      expect(@shipping).to be_valid
    end

    it "「購入id」が空では登録できない" do
      @shipping.purchase_id = nil
      @shipping.valid?
      expect(@shipping.errors.full_messages).to include("Purchase can't be blank")
    end

    it "「郵便番号」が空では登録できない" do
      @shipping.zip = nil
      @shipping.valid?
      expect(@shipping.errors.full_messages).to include("Zip can't be blank")
    end

    it "「郵便番号」は「数字3桁-数字4桁」の形式でなければ登録できない" do
      @shipping.zip = "a00-0000"
      @shipping.valid?
      expect(@shipping.errors.full_messages).to include("Zip is invalid. Include hyphen(-)")
    end

    it "「郵便番号」は「-」を含む形式でなければ登録できない" do
      @shipping.zip = "0000000"
      @shipping.valid?
      expect(@shipping.errors.full_messages).to include("Zip is invalid. Include hyphen(-)")
    end

    it "「都道府県」が空では登録できない" do
      @shipping.prefecture = nil
      @shipping.valid?
      expect(@shipping.errors.full_messages).to include("Prefecture can't be blank")
    end

    it "「市区町村」が空では登録できない" do
      @shipping.city = nil
      @shipping.valid?
      expect(@shipping.errors.full_messages).to include("City can't be blank")
    end

    it "「番地」が空では登録できない" do
      @shipping.address = nil
      @shipping.valid?
      expect(@shipping.errors.full_messages).to include("Address can't be blank")
    end

    it "「電話番号」は10桁以上の必要がある" do
      @shipping.phone = "000000000"
      @shipping.valid?
      expect(@shipping.errors.full_messages).to include("Phone is invalid. Phone should be 10 or 11 digits long.")
    end

    it "「電話番号」は11桁以下の必要がある" do
      @shipping.phone = "000000000000"
      @shipping.valid?
      expect(@shipping.errors.full_messages).to include("Phone is invalid. Phone should be 10 or 11 digits long.")
    end

    it "「電話番号」は数字のみである必要がある" do
      @shipping.phone = "000-000-0000"
      @shipping.valid?
      expect(@shipping.errors.full_messages).to include("Phone is invalid. Phone should be 10 or 11 digits long.")
    end
  end
end
