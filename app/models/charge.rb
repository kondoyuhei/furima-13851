class Charge < ActiveHash::Base
  # 商品の送料負担
  self.data = [
    { id: 1, name: '---' },
    { id: 2, name: '購入者負担（着払い）' },
    { id: 3, name: '出品者負担（送料込み）' },
  ]
end