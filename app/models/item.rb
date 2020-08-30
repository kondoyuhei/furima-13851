class Item < ApplicationRecord
  belongs_to :user
  has_one :purchase

  has_one_attached :image

  with_options presence: true do
    validates :name,      { length: { maximum: 40 } }      # 商品名
    validates :note,      { length: { maximum: 1000 } } # 商品説明
    validates :price,     numericality: {
      only_integer: true,
      greater_than_or_equal_to: 300,
      less_than_or_equal_to: 9_999_999,
      message: "is out of setting range"
    } # 商品価格
    validates :image    # 商品画像
    validates :user_id  # 出品者
    validates :category,  numericality: { other_than: 0, message: "can't be blank" } # カテゴリー
    validates :condition, numericality: { other_than: 0, message: "can't be blank" } # 状態
    validates :charge,    numericality: { other_than: 0, message: "can't be blank" } # 送料負担
    validates :from,      numericality: { other_than: 0, message: "can't be blank" } # 発送元
    validates :period,    numericality: { other_than: 0, message: "can't be blank" } # 出荷日数
  end

  # 商品が販売中かどうか判定するメソッド
  # 商品が販売中であればtrue, 購入済みであればfalseを返す
  def on_sale
    return true if Purchase.where(item_id: id).empty?

    false
  end

  # 引数としてユーザーを渡すと、その商品の出品者かどうか判定するメソッド
  # 出品者であればtrue,出品者でなければfalseを返す
  def owner(target)
    return true if user_id == target.id

    false
  end
end
