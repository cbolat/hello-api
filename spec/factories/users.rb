FactoryBot.define do
  factory :user do
    name { Faker::Movies::StarWars.character}
    job { nil }
  end
end
