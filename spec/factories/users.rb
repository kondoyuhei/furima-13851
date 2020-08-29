require 'faker/japanese'

FactoryBot.define do
  factory :user do
    nickname { Faker::Name.name }
    name_sei { Faker::Japanese::Name.last_name }
    name_mei { Faker::Japanese::Name.first_name }
    yomi_sei { Faker::Japanese::Name.last_name.yomi }
    yomi_mei { Faker::Japanese::Name.first_name.yomi }
    email { Faker::Internet.free_email }
    password = "a1" + Faker::Internet.password(min_length: 4)
    password { password }
    password_confirmation { password }
    birthday { Faker::Date.birthday }
  end
end
