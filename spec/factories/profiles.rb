FactoryBot.define do
  factory :profile do
    # employeeモデルアソシエーション
    association :profile,
    # titleカラムが50文字のランダム文字列
    profile { Faker::Lorem.characters(number:50) }
  end
end