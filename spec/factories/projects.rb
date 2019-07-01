FactoryBot.define do
  factory :project do
    title { Faker::Hacker.noun }
    created_by { Faker::Number.number(10) }
  end
end
