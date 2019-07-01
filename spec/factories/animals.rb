FactoryBot.define do
  factory :animal do
    name { Faker::Lorem.name }
    vegetarian { false }
    farm { nil }
  end
end
