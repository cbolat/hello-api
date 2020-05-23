# spec/factories/todos.rb
FactoryBot.define do
  factory :singer do
    name { Faker::Lorem.word }
    created_by { Faker::Number.number(10) }
  end
end