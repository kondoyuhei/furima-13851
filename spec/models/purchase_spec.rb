require 'rails_helper'

RSpec.describe Shipping, type: :model do
  describe '#create' do
    before do
      @purchase = FactoryBot.build(:purchase)
    end

    it "「購入id」「ユーザーid」が存在すれば登録できる" do
      expect(@purchase).to be_valid
    end

    it "「商品id」が空では登録できない" do
      @purchase.item_id = nil
      @purchase.valid?
      expect(@purchase.errors.full_messages).to include("Item can't be blank")
    end

    it "「ユーザーid」が空では登録できない" do
      @purchase.user_id = nil
      @purchase.valid?
      expect(@purchase.errors.full_messages).to include("User can't be blank")
    end
  end
end
