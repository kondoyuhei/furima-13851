class Shipping < ApplicationRecord
  attr_accessor :token
  with_options presence: true do
    # 正規表現の条件指定
    format_zip = /\A[0-9]{3}-[0-9]{4}\z/ # 郵便番号
    format_phone = /\A[0-9]{10,11}\z/ # 電話番号
    # バリデーション設定
    validates :purchase_id # 購入id
    validates :zip, format: {
      with: format_zip,
      message: "is invalid. Include hyphen(-)"
    }                      # 郵便番号
    validates :prefecture, numericality: {
      other_than: 0, message: "can't be blank"
    }                      # 都道府県
    validates :city        # 市区町村
    validates :address     # 住所
    validates :phone, format: {
      with: format_phone,
      message: "is invalid. Phone should be 10 or 11 digits long."
    }                      # 電話番号
    validates :token # トークン
  end
end
