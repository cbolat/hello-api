FactoryBot.define do
  factory :employee do
    name { Faker::Games::Witcher.character }
    paid { false }
    project { nil }
  end
end
