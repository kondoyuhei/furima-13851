class Shipping < ApplicationRecord
  with_options presence: true do
    # 正規表現の条件指定
    format_zip = /\A[0-9]{3}-[0-9]{4}\z/
    format_phone = /\A[0-9]{10,11}\z/
    # バリデーション設定
    validates :purchase_id # 購入id
    validates :zip, format: {
      with: zip_code,
      message: "is invalid. Include hyphen(-)"
    }                      # 郵便番号
    validates :prefecture, numericality: {
      other_than: 0, message: "can't be blank"
    }                      # 都道府県
    validates :city        # 市区町村
    validates :address     # 住所
    validates :phone, format: {
      with: /\A[0-9]{10,11}\z/,
      message: "is invalid. Phone should be 10 or 11 digits long."
    }                      # 電話番号
  end
end
