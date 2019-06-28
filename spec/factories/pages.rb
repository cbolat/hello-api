# spec/factories/pages.rb
FactoryBot.define do
  factory :page do
    title { Faker::StarWars.character }
    created_by { Faker::Number.number(10) }
    book_id nil
  end
end