FactoryBot.define do
  factory :article do
    # employeeモデルアソシエーション
    association :employee
    # titleカラムが50文字のランダム文字列
    title { Faker::Lorem.characters(number:55) }
    # contentカラムが50文字のランダム文字列
    content { Faker::Lorem.characters(number:55) }
  end
end
