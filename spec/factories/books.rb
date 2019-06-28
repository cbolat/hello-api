# spec/factories/books.rb
FactoryBot.define do
  factory :book do
    title { Faker::Lorem.word }
    created_by { Faker::Number.number(10) }
  end
end