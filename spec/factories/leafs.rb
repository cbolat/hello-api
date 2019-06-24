# spec/factories/items.rb
FactoryBot.define do
  factory :leaf do
    name { Faker::StarWars.character }
    done false
    todo_id nil
  end
end