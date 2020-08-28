require 'faker/japanese'

FactoryBot.define do
  factory :item do
    name {Faker::Book.title}
    note {Faker::Lorem.sentence}
    price {rand(300..9999999)}
    category {rand(1..10)}
    condition {rand(1..6)}
    charge {rand(1..4)}
    from {rand(1..47)}
    period {rand(1..3)}
    association :user
    image { Rack::Test::UploadedFile.new(File.join(Rails.root, 'public/images/sample.png')) }
  end
end