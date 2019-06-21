FactoryBot.define do
  factory :job do
    title { Faker::Lorem.word}
    description {  Faker::Movies::StarWars.character}
  end
end
