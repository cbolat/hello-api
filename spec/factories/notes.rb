FactoryBot.define do
  factory :note do
    title { Faker::University.name }
    created_by { Faker::Number.number(10) }
  end
end
