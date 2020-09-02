FactoryBot.define do
  factory :shipping do
    purchase_id { rand(1..1000) } # 購入id
    zip        { rand(1..999).to_s.rjust(3, '0') + "-" + rand(1..9999).to_s.rjust(4, '0') } # 郵便番号
    prefecture { rand(1..47) } # 都道府県
    city       { Faker::Address.city } # 市区町村
    address   { Faker::Address.street_address } # 番地
    phone      { "0" + rand(1..999_999_999).to_s.center(9, '0') } # 電話番号
  end
end
