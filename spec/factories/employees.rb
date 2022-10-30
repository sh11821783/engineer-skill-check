FactoryBot.define do
  factory :employee do
    first_name { Faker::Lorem.characters(number: 10) }
    last_name { Faker::Lorem.characters(number: 10) }
    # 実際のemailアドレスの形を指定
    email { Faker::Internet.email }
    account { Faker::Lorem.characters(number: 10) }
    password { Faker::Lorem.characters(number: 10) }
  end
end
