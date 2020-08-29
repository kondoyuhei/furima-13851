class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  with_options presence: true do
    # 正規表現の条件指定
    format_zenkaku  = /\A[ぁ-んァ-ン一-龥]/ # 全角（全角ひらがな・全角カタカナ・漢字）
    format_katakana = /\A[ァ-ン]/ # 全角カタカナ

    # エラーメッセージ
    message_zenkaku = "is invalid. Input full-width characters." # 全角で入力させる
    message_katakana = "is invalid. Input full-width Katakanas." # 全角カタカナで入力させる

    # ニックネーム
    validates :nickname
    # パスワード
    validates :password, format: { with: /\A(?=.*?[a-z])(?=.*?[\d])[a-z\d]+\z/i, message: "is invalid." }
    # 姓
    validates :name_sei, format: { with: format_zenkaku, message: message_zenkaku }
    # 名
    validates :name_mei, format: { with: format_zenkaku, message: message_zenkaku }
    # 姓読み
    validates :yomi_sei, format: { with: format_katakana, message: message_katakana }
    # 名読み
    validates :yomi_mei, format: { with: format_katakana, message: message_katakana }
    # 生年月日
    validates :birthday
  end
end
