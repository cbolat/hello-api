FactoryBot.define do
  factory :song do
    name { Faker::StarWars.character }
    done {false}
    singer_id {nil}
  end
end