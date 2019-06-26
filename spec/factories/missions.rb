FactoryBot.define do
  factory :mission do
    code { Faker::Number.number(10) }
    todo nil
  end
end
