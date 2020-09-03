class CreateShippings < ActiveRecord::Migration[6.0]
  def change
    create_table :shippings do |t|
      t.references :purchase,   foreign_key: true # 購入商品
      t.string     :zip,        null: false # 郵便番号
      t.integer    :prefecture, null: false # 都道府県
      t.string     :city,       null: false # 市区町村
      t.string     :address,    null: false # 番地
      t.string     :building                # 建物
      t.string     :phone,      null: false # 電話番号
      t.timestamps
    end
  end
end
