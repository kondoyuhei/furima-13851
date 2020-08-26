class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  with_options presence: true do
    # ニックネーム
    validates :nickname
    # Eメール
    validates :email, format: { with: /[\w\-._]+@[\w\-._]+\.[A-Za-z]+/, message: "is invalid. Email must include '@'. " }
    # パスワード
    validates :password, format: { with: /\A(?=.*?[a-z])(?=.*?[\d])[a-z\d]+\z/i, message: "is invalid." }
    # 姓
    validates :name_sei, format: { with: /\A[ぁ-んァ-ン一-龥]/, message: "is invalid. Input full-width characters." }
    # 名
    validates :name_mei, format: { with: /\A[ぁ-んァ-ン一-龥]/, message: "is invalid. Input full-width characters." }
    # 姓読み
    validates :yomi_sei, format: { with: /\A[ァ-ン]/, message: "is invalid. Input full-width Katakanas." }
    # 名読み
    validates :yomi_mei, format: { with: /\A[ァ-ン]/, message: "is invalid. Input full-width Katakanas." }
    # 生年月日
    validates :birthday
  end
end
