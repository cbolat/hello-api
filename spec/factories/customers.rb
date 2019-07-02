FactoryBot.define do
  factory :customer do
    name { Faker::Superhero.name }
    done { false }
    todo_id { nil }
  end
end
