class Item < ApplicationRecord
  belongs_to :user
  has_one :purchase
  has_one_attached :image

  with_option presence: true do
    validates :name     # 商品名
    validates :note     # 商品説明
    validates :price    # 商品価格
    validates :image    # 商品画像
    validates :user_id  # 出品者
    validates :category # カテゴリー
    validates :conditon # 状態
    validates :charge   # 送料負担
    validates :from     # 発送元
    validates :period   # 出荷日数
  end
end
