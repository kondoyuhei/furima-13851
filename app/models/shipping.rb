class Shipping < ApplicationRecord
  with_options presence: true do
    validates :purchase_id
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
end
