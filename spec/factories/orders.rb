FactoryBot.define do
  factory :order do
    name { Faker::Movies::StarWars.character }
    price 123
    todo nil
  end
end
