FactoryBot.define do
  factory :post do
    name { Faker::Games::ElderScrolls.name }
    done { false }
    note { nil }
  end
end
