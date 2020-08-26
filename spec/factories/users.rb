require 'faker/japanese'

# FactoryBot.define do
#   factory :user do
#     nickname {"testing"}
#     name_sei {"アイ"}
#     name_mei {"ウエオ"}
#     yomi_sei {"アイ"}
#     yomi_mei {"ウエオ"}
#     email {"abc@defe.com"}
#     password = "password1"
#     password {password}
#     password_confirmation {password}
#     birthday {"2020-08-27"}
#   end
# end

FactoryBot.define do
  factory :user do
    nickname {Faker::Name.name}
    name_sei {Faker::Japanese::Name.last_name}
    name_mei {Faker::Japanese::Name.first_name}
    yomi_sei {Faker::Japanese::Name.last_name.yomi}
    yomi_mei {Faker::Japanese::Name.first_name.yomi}
    email {Faker::Internet.free_email}
    password = Faker::Internet.password(min_length: 6)
    password {password}
    password_confirmation {password}
    birthday {Faker::Date.birthday}
  end
end