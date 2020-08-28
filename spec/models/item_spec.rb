require 'rails_helper'

RSpec.describe Item, type: :model do
  describe '#create' do
    before do
      @item = FactoryBot.create(:item)
    end

    it "「商品画像」「商品名」「商品説明」「カテゴリー」「商品の状態」「配送料の負担」「発送元の地域」「発送までの日数」「価格」が存在すれば登録できる" do
      expect(@item).to be_valid
    end

    it "「商品画像」が空では登録できない" do
      @item.image = nil
      @item.valid?
      expect(@item.errors.full_messages).to include("Image can't be blank")
    end

    it "「商品名」が空では登録できない" do
      @item.name = nil
      @item.valid?
      expect(@item.errors.full_messages).to include("Name can't be blank")
    end

    it "「商品説明」が空では登録できない" do
      @item.note = nil
      @item.valid?
      expect(@item.errors.full_messages).to include("Note can't be blank")
    end

    it "「カテゴリー」が空では登録できない" do
      @item.category = nil
      @item.valid?
      expect(@item.errors.full_messages).to include("Category can't be blank")
    end

    it "「商品の状態」が空では登録できない" do
      @item.condition = nil
      @item.valid?
      expect(@item.errors.full_messages).to include("Condition can't be blank")
    end

    it "「配送料の負担」が空では登録できない" do
      @item.charge = nil
      @item.valid?
      expect(@item.errors.full_messages).to include("Charge can't be blank")
    end

    it "「発送元の地域」が空では登録できない" do
      @item.from = nil
      @item.valid?
      expect(@item.errors.full_messages).to include("From can't be blank")
    end

    it "「発送までの日数」が空では登録できない" do
      @item.period = nil
      @item.valid?
      expect(@item.errors.full_messages).to include("Period can't be blank")
    end

    it "「価格」が空では登録できない" do
      @item.price = nil
      @item.valid?
      expect(@item.errors.full_messages).to include("Price can't be blank")
    end

    it "「価格」が299円以下では登録できない" do
      @item.price = 299
      @item.valid?
      expect(@item.errors.full_messages).to include("Price is out of setting range")
    end

    it "「価格」が10000000円以上では登録できない" do
      @item.price = 10000000
      @item.valid?
      expect(@item.errors.full_messages).to include("Price is out of setting range")
    end

  end
end
