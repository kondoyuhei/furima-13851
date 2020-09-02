class Purchase < ApplicationRecord
  with_options presence: true do
    validates :item_id
    validates :user_id
  end
end
