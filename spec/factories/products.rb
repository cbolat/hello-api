FactoryBot.define do
  factory :product do
    name { Faker::StarWars.character }
    isInStock { false }
    category { nil }
  end
end
