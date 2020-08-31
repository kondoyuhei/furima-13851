class PurchaseShipping

  include ActiveModel::Model
  attr_accessor :user_id, :item_id,
    :purchase_id, :zip, :prefecture, :city,
    :address, :building, :phone

  # バリデーションの記述
  with_options presence: true do
    validates :purchase_id # 購入id
    validates :zip, format: {
      with: /\A[0-9]{3}-[0-9]{4}\z/,
      message: "is invalid. Include hyphen(-)"
    }                      # 郵便番号
    validates :prefecture, numericality: {
      other_than: 0, message: "can't be blank"
    }                      # 都道府県
    validates :city        # 市区町村
    validates :address     # 住所
    validates :phone, format: {
      with: /\d{10,11}/,
      message: "is invalid. Remove hyphen(-)(s)"
    }                      # 電話番号
  end

  def save
    # 購入情報の作成
    purchase = Purchase.create(user_id: user_id, item_id: item_id)
    # 配送情報の作成
    Shipping.create(
      purchase_id: purchase.id,
      zip: zip,
      prefecture: prefecture,
      city: city,
      address: address,
      buidling: building,
      phone: phone
    )
  end
end
