FactoryBot.define do
  factory :item do
    association :user
    name { Faker::Book.title }
    note { Faker::Lorem.sentence }
    price { rand(300..9_999_999) }
    category { rand(1..10) }
    condition { rand(1..6) }
    charge { rand(1..2) }
    from { rand(1..47) }
    period { rand(1..3) }
    image { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/files/test.png'), 'image/png') }
  end
end
